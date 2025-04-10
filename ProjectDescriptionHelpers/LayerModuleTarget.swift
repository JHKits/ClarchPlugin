//
//  LayerModuleTarget.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/4/25.
//

import ProjectDescription


public enum LayerModuleTargetType: Hashable {
    case app
    case sources
    case repositoryInterface(_ repositoryName: String)
    
    case interface
    case implementation
    case testing
    case example
    case tests
    
    public var rawValue: String {
        return switch self {
        case .app: "app"
        case .sources: "sources"
        case let .repositoryInterface(repositoryName): "\(repositoryName.lowercasedFirst)RepositoryInterface"
        case .interface: "interface"
        case .implementation: "implementation"
        case .testing: "testing"
        case .example: "example"
        case .tests: "tests"
        }
    }
    
    public var directoryName: String? {
        switch self {
        case .app, .sources: nil
        default: self.rawValue.capitalizedFirst
        }
    }
    
    public var product: Product {
        return switch self {
        case .app: .app
        case .repositoryInterface: .staticFramework
        case .interface, .implementation, .testing: .staticFramework
        case .example: .app
        case .tests: .unitTests
        case .sources: .staticFramework
        }
    }
    
    public var targetTypeDependences: [LayerModuleTargetType] {
        return switch self {
        case .app: []
        case .interface: []
        case .implementation: [.interface]
        case .testing: [.interface]
        case .example: [.implementation, .testing]
        case .tests: [.implementation, .testing]
        case .repositoryInterface: []
        case .sources: []
        }
    }
    
    public var bundleIdDescription: String? {
        return switch self {
        case .app, .sources: nil
        default:
            self.rawValue.lowercased()
        }
    }
    
    public func toSelection() -> LayerModuleTargetSelection {
        return switch self {
        case .app: .app
        case .sources: .sources
        case let .repositoryInterface(repositoryName): .repositoryInterface(repositoryName)
        case .interface: .interface
        case .implementation: .implementation
        case .testing: .testing
        case .example: .example
        case .tests: .tests
        }
    }
}

public struct LayerModuleTarget {
    let moduleName: String
    let moduleType: LayerModuleType
    let targetType: LayerModuleTargetType
    
    public init(_ moduleName: String,
                moduleType: LayerModuleType,
                targetType: LayerModuleTargetType) {
        self.moduleName = moduleName
        self.moduleType = moduleType
        self.targetType = targetType
    }
    
    var layerModuleName: String {
        switch moduleType {
        case .app: "\(moduleName)"
        case .diContainer: "\(moduleName)DIContainer"
        case .core, .shared: "\(moduleType.rawValue.capitalizedFirst)\(moduleName)"
        default: "\(moduleName)\(moduleType.rawValue.capitalizedFirst)"
        }
    }
    
    var name: String {
        return switch targetType {
        case .app, .sources: "\(layerModuleName)"
        case .repositoryInterface: targetType.rawValue.capitalizedFirst
        default:
            "\(layerModuleName)\(targetType.rawValue.capitalizedFirst)"
        }
    }
    
    var modulePath: ProjectDescription.Path {
        let dirs = [moduleType.directoryName, layerModuleName]
        return .relativeToRoot(dirs.joined(separator: "/"))
    }
    
    var path: ProjectDescription.Path {
        if let directoryName = targetType.directoryName {
            return modulePath.appending(directoryName)
        }
        return modulePath
    }
    
    // MARK: - For Target
    private func defaultBundleId(appName: String? = nil,
                                 organizationName: String? = nil) -> String {
        return [
            organizationName,
            appName,
            moduleType.bundleIdDescription,
            moduleName,
            targetType.bundleIdDescription
        ]
            .compactMap{ !($0?.isEmpty ?? true) ? $0 : nil }
            .joined(separator: ".")
            .lowercased()
    }
    
    private func defaultSourceFileGlob() -> ProjectDescription.SourceFileGlob {
        return .glob(path.appending("Sources/**"))
    }
    
    private func defaultResourceFileElement() -> ProjectDescription.ResourceFileElement? {
        return switch moduleType {
        case .app:
                .glob(
                    pattern: path.appending("Resources/**"),
                    excluding: [path.appending("Resources/Info.plist")]
                )
        case .feature:
            switch targetType {
            case .implementation: .glob(
                pattern: path.appending("Resources/**"),
                excluding: [path.appending("Resources/Info.plist")]
            )
            default: nil
            }
            
        default: nil
        }
    }
    
    public func toTarget(
        appName: String? = nil,
        organizationName: String? = nil,
        options: LayerModuleTargetOption = .init(),
        layerModuleDependencies: [LayerModuleDependency] = [],
        targetDependencies: [TargetDependency] = []) -> Target {
            // BundleId
            let bundleId = options.bundleId ?? defaultBundleId(appName: appName,
                                                               organizationName: organizationName)
            
            // Sources
            let sources: SourceFilesList = .sourceFilesList(globs: [
                defaultSourceFileGlob()
            ] + (options.additionalSources ?? []))
            
            // Resources
            let resources: ResourceFileElements = .resources(
                [defaultResourceFileElement()].compactMap { $0 }
                + (options.additionalResources ?? []))
            
            // Dependencies
            let architectureTargetTypeDenpendencies = targetType.targetTypeDependences
            
            let architectureTargetDependencies: [TargetDependency] = architectureTargetTypeDenpendencies.map { targetTypeDependency in
                guard moduleType.layerModuleTargets.contains(targetTypeDependency) else {
                    return nil
                }
                let dependLayerModuleTarget = LayerModuleTarget(moduleName,
                                                                moduleType: moduleType,
                                                                targetType: targetTypeDependency)
                return .target(name: dependLayerModuleTarget.name,
                               condition: nil)
            }
                .compactMap { $0 }
            
            let layerModuleTargetDependencies: [TargetDependency] = switch moduleType {
            case .diContainer:
                layerModuleDependencies
                    .map{ $0.toDIContainrTargetDependencies() }
                    .flatMap { $0 }
            default:
                switch targetType {
                case .app, .sources, .interface, .repositoryInterface:
                    layerModuleDependencies
                        .map{ $0.toTargetDependency() }
                case .tests:
                    layerModuleDependencies
                        .map{ $0.toTestsTargetDependencies() }
                        .flatMap { $0 }
                default: []
                }
            }
            
            let dependencies = [
                architectureTargetDependencies,
                layerModuleTargetDependencies,
                targetDependencies
            ].flatMap { $0 }
            
            return .target(name: name,
                           destinations: options.destinations,
                           product: targetType.product,
                           productName: options.productName,
                           bundleId: bundleId,
                           deploymentTargets: options.deploymentTargets,
                           infoPlist: options.infoPlist,
                           sources: sources,
                           resources: resources,
                           copyFiles: options.copyFiles,
                           headers: options.headers,
                           entitlements: options.entitlements,
                           scripts: options.scripts,
                           dependencies: dependencies,
                           settings: options.settings,
                           coreDataModels: options.coreDataModels,
                           environmentVariables: options.environmentVariables,
                           launchArguments: options.launchArguments,
                           additionalFiles: options.additionalFiles,
                           buildRules: options.buildRules,
                           mergedBinaryType: options.mergedBinaryType,
                           mergeable: options.mergeable)
        }
}

public struct LayerModuleTargetOption {
    var destinations: ProjectDescription.Destinations
    var productName: String?
    var bundleId: String?
    var deploymentTargets: ProjectDescription.DeploymentTargets?
    var infoPlist: ProjectDescription.InfoPlist?
    var additionalSources: [ProjectDescription.SourceFileGlob]?
    var additionalResources: [ProjectDescription.ResourceFileElement]?
    var copyFiles: [ProjectDescription.CopyFilesAction]?
    var headers: ProjectDescription.Headers?
    var entitlements: ProjectDescription.Entitlements?
    var scripts: [ProjectDescription.TargetScript]
    var dependencies: [ProjectDescription.TargetDependency]
    var settings: ProjectDescription.Settings?
    var coreDataModels: [ProjectDescription.CoreDataModel]
    var environmentVariables: [String : ProjectDescription.EnvironmentVariable]
    var launchArguments: [ProjectDescription.LaunchArgument]
    var additionalFiles: [ProjectDescription.FileElement]
    var buildRules: [ProjectDescription.BuildRule]
    var mergedBinaryType: ProjectDescription.MergedBinaryType
    var mergeable: Bool
    
    public init(destinations: ProjectDescription.Destinations  = [.iPhone,
                                                                  .iPad],
                productName: String? = nil,
                bundleId: String? = nil,
                deploymentTargets: ProjectDescription.DeploymentTargets? = nil,
                infoPlist: ProjectDescription.InfoPlist? = .default,
                additionalSources: [ProjectDescription.SourceFileGlob]? = nil,
                additionalResources: [ProjectDescription.ResourceFileElement]? = nil,
                copyFiles: [ProjectDescription.CopyFilesAction]? = nil,
                headers: ProjectDescription.Headers? = nil,
                entitlements: ProjectDescription.Entitlements? = nil,
                scripts: [ProjectDescription.TargetScript] = [],
                dependencies: [ProjectDescription.TargetDependency] = [],
                settings: ProjectDescription.Settings? = nil,
                coreDataModels: [ProjectDescription.CoreDataModel] = [],
                environmentVariables: [String : ProjectDescription.EnvironmentVariable] = [:],
                launchArguments: [ProjectDescription.LaunchArgument] = [],
                additionalFiles: [ProjectDescription.FileElement] = [],
                buildRules: [ProjectDescription.BuildRule] = [],
                mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
                mergeable: Bool = false) {
        self.destinations = destinations
        self.productName = productName
        self.bundleId = bundleId
        self.deploymentTargets = deploymentTargets
        self.infoPlist = infoPlist
        self.additionalSources = additionalSources
        self.additionalResources = additionalResources
        self.copyFiles = copyFiles
        self.headers = headers
        self.entitlements = entitlements
        self.scripts = scripts
        self.dependencies = dependencies
        self.settings = settings
        self.coreDataModels = coreDataModels
        self.environmentVariables = environmentVariables
        self.launchArguments = launchArguments
        self.additionalFiles = additionalFiles
        self.buildRules = buildRules
        self.mergedBinaryType = mergedBinaryType
        self.mergeable = mergeable
    }
}
