#!/bin/zsh

function text_effect {
  case "$1" in
    default) echo 0 ;;
    bold) echo 1 ;;
    underline) echo 4 ;;
    invisible) echo 8 ;;
  esac
}

function text_color {
  case "$1" in
    black) echo 30 ;;
    red) echo 31 ;;
    green) echo 32 ;;
    yellow) echo 33 ;;
    blue) echo 34 ;;
    magenta) echo 35 ;;
    cyan) echo 36 ;;
    white) echo 0 ;;
  esac
}

function styled_text {
  effect="0" color="37" text=""
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -e)
        effect=$(text_effect "$2")
        shift 2
        ;;
      -c)
        color=$(text_color "$2")
        shift 2
        ;;
      *)
        text="$1"
        shift
        ;;
    esac
  done
  echo -e "\033[${effect};${color}m${text}\033[0m"
}

function error_message {
  exit=0 prefix="Error: " effect=""
  error_code=1 message=""
  while [[ "$#" -gt 0 ]]; do
    case "$1" in
      -b)
        effect=("-e" "bold")
        shift
        ;;
      -e)
        exit=1
        shift
        ;;
      -c)
        error_code="$2"
        shift 2
        ;;
      *)
        if [[ -z $message ]]; then
          message="$1"
        fi
        shift
        ;;
    esac
  done
  if [[ -z "$message" ]]; then
    message="An error has occurred."
  fi
  styled_text -c red "${effect[@]}" "$prefix$message\n"
  if [[ "$exit" -eq 1 ]]; then
    exit "$error_code"
  fi
}

file_name=$(basename "$0")

function help {
    local usage_prefix="║ Usage: ./$file_name <module> --name <name> [options]"
    local total_width=56
    local padding=$((total_width - ${#usage_prefix}))
    local spaces=$(printf '%*s' "$padding" '')
    
    echo "╔═══════════════════════════════════════════════════════╗"
    echo "║                     ClarchPlugin                      ║"
    echo "╠═══════════════════════════════════════════════════════╣"
    echo "${usage_prefix}${spaces}║"
    echo "╚═══════════════════════════════════════════════════════╝"
    echo ""
    echo "📁 Supported Modules"
    echo ""
    
    echo "[App]                                                   "
    echo "app                    --name <name>                    "
    echo "diContainer            [--name <name>]  (default: \"\") "
    echo "coordinator            [--name <name>]  (default: \"\") "
    echo "coordinatorInterface   [--name <name>]  (default: \"\") "
    echo "                                                        "
    echo "                                                        "
    echo "[Feature]                                               "
    echo "feature --name (required)                               "
    echo "                                                        "
    echo "                                                        "
    echo "[Domain]                                                "
    echo "domain                 --name <name>                    "
    echo "baseDomain             --name <name>                    "
    echo "repositoryInterfaces   [--name <name>]  (default: \"\") "
    echo "                       [--repository-names <name1,...>] "
    echo "                                                        "
    echo "                                                        "
    echo "[Data]                                                  "
    echo "data                   --name <name>                    "
    echo "baseData               --name <name>                    "
    echo "                                                        "
    echo "                                                        "
    echo "[Infrastructure]                                        "
    echo "infrastructure         --name <name>                    "
    echo "                                                        "
    echo "                                                        "
    echo "[Feature]                                               "
    echo "feature                --name <name>                    "
    echo "                                                        "
    echo "                                                        "
    echo "[Core]                                                  "
    echo "core                   --name <name>                    "
    echo "                                                        "
    echo "                                                        "
    echo "[Shared]                                                "
    echo "shared                 --name <name>                    "
    echo "                                                        "
    echo "                                                        "
    echo "[Header Setting Options]                                "
    echo "  --author <name>             (default: Mac User Name)  "
    echo "  --current-date <MM/DD/YY>   (default: Current Date)   "
    echo "  --copyright-year <YYYY>     (default: Current Year)   "
    echo "  --organization <name>                                 "
    echo "※ If the organization is missing,                       "
    echo "  the copyright notice will not be generated.           "
    echo "                                                        "
}


ALLOWED_LAYERS=("app" "diContainer" "coordinator" "coordinatorInterface" "feature" "domain" "baseDomain" "repositoryInterface" "repositoryInterfaces" "data" "baseData" "infrastructure" "core" "shared")


module="$1"
shift
name=""
repository_name_array=()

author=$(osascript -e "long user name of (system info)")
current_date=$(date +"%-m/%-d/%y")
copyright_year=$(date +%Y)
organization=""

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -h)
      help
      exit 0
      ;;
    --name)
      name="$2"
      shift 2
      ;;
    --repository-names)
      repository_names="$2"
      IFS=',' read -r -A repository_name_array <<< "$repository_names"
      shift 2
      ;;
    --author)
      name="$2"
      shift 2
      ;;
    --current-date)
      current_date="$2"
      shift 2
      ;;
    --copyright-year)
      copyright_year="$2"
      shift 2
      ;;
    --organization)
      organization="$2"
      shift 2
      ;;
    *)
      error_message "Invalid parameter: $1"
      help
      exit 1
      ;;
  esac
done

if [[ ! " ${ALLOWED_LAYERS[@]} " =~ " ${module} " ]]; then
  error_message "\"${module}\" is not a valid module."
  help
  exit 1
fi

name_option=()
if [[ -n "$name" ]]; then
    name_option=(--name "$name")
fi

header_options=(--author "$author" --current-date "$current_date")
if [[ -n "$organization" ]]; then
  header_options+=(--copyright-year "$copyright_year" --organization "$organization")
fi

case "${module}" in
  diContainer|coordinator|coordinatorInterface|baseDomain|baseData)
    tuist scaffold $module "${name_option[@]}" "${header_options[@]}"
    ;;
  app|feature|domain|data|infrastructure|core|shared)
    if [[ ${#name_option[@]} -eq 0 ]]; then
      error_message "--name is required for module \"${module}\""
      help
      exit 1
    fi
    tuist scaffold $module "${name_option[@]}" "${header_options[@]}"
    ;;
  repositoryInterfaces)
    joined_repository_names=$(IFS=','; echo "${repository_name_array[*]}")
    repository_names_option=()
    if [[ -n "$joined_repository_names" ]]; then
      repository_names_option=(--repository-names "${joined_repository_names}")
    fi
    styled_text -c green -e bold "Generating ${(C)name}RepositoryInterfaces..."
    tuist scaffold repositoryInterfaces "${name_option[@]}" "${repository_names_option[@]}" "${header_options[@]}"
    echo ""
    for repository_name in "${repository_name_array[@]}"; do
      styled_text -c green -e bold "Generating "${(C)repository_name}"RepositoryInterface..."
      tuist scaffold repositoryInterface "${name_option[@]}" --repository-name $repository_name "${header_options[@]}"
      echo ""
    done
    ;;
  *)
    error_message "\"${module}\" is not a valid module."
    help
    exit 1
    ;;
esac
