//
//  LayerModule.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/4/25.
//

import ProjectDescription

public struct LayerModule {
    let moduleType: LayerModuleType
    let appName: String?
    let moduleName: String
    let organizationName: String?
    let additionalTargets: [ProjectDescription.Target]
    let layerModuleDependencies: [LayerModuleDependency]
    let targetDependencies: [TargetDependency]
    
    let options: ProjectDescription.Project.Options
    let packages: [ProjectDescription.Package]
    let settigns: ProjectDescription.Settings?
    
    let schemes: [ProjectDescription.Scheme]
    let fileHeaderTemplate: ProjectDescription.FileHeaderTemplate?
    let additionalFiles: [ProjectDescription.FileElement]
    let resourceSynthesisizers: [ProjectDescription.ResourceSynthesizer]
    
    private let repositoryTargetNames: [String]?
    let targetOptions: [LayerModuleTargetOptionType: LayerModuleTargetOption]
    
    public init(moduleType: LayerModuleType,
                appName: String?,
                moduleName: String,
                organizationName: String? = nil,
                repositoryTargetNames: [String]? = nil,
                additionalTargets: [ProjectDescription.Target] = [],
                layerModuleDependencies: [LayerModuleDependency] = [],
                targetDependencies: [TargetDependency] = [],
                targetOptions: [LayerModuleTargetOptionType : LayerModuleTargetOption] = [:],
                options: ProjectDescription.Project.Options = .options(),
                packages: [ProjectDescription.Package] = [],
                settings: ProjectDescription.Settings? = nil,
                schemes: [ProjectDescription.Scheme] = [],
                fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                additionalFiles: [ProjectDescription.FileElement] = [],
                resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default
    ) {
        self.moduleType = moduleType
        self.appName = appName
        self.moduleName = moduleName.capitalizedFirst
        self.organizationName = organizationName
        self.repositoryTargetNames = repositoryTargetNames?.map{ $0.capitalizedFirst }
        self.additionalTargets = additionalTargets
        self.layerModuleDependencies = layerModuleDependencies
        self.targetDependencies = targetDependencies
        self.targetOptions = targetOptions
        self.options = options
        self.packages = packages
        self.settigns = settings
        self.schemes = schemes
        self.fileHeaderTemplate = fileHeaderTemplate
        self.additionalFiles = additionalFiles
        self.resourceSynthesisizers = resourceSynthesizers
    }
    
    public func toProject() -> ProjectDescription.Project {
        let targets = switch moduleType {
        case .repositoryInterfaces:
            generateRepositoryInterfaceTargets()
        default:
            generateModuleTargets()
        }
        return Project(name: layerModuleName,
                       organizationName: organizationName,
                       options: options,
                       packages: packages,
                       settings: settigns,
                       targets: targets + additionalTargets,
                       schemes: schemes,
                       fileHeaderTemplate: fileHeaderTemplate,
                       additionalFiles: additionalFiles,
                       resourceSynthesizers: resourceSynthesisizers)
    }
}


extension LayerModule {
    var layerModuleName: String {
        switch moduleType {
        case .app: "\(moduleName)"
        case .diContainer: "\(moduleName)DIContainer"
        case .core, .shared: "\(moduleType.rawValue.capitalizedFirst)\(moduleName)"
        default: "\(moduleName)\(moduleType.rawValue.capitalizedFirst)"
        }
    }
    
    func generateModuleTargets() -> [Target] {
        if moduleType == .repositoryInterfaces {
            return generateRepositoryInterfaceTargets()
        }
        return generateDefaultTargets()
    }
    
    private func generateDefaultTargets() -> [Target] {
        return moduleType.layerModuleTargets.map { targetType in
            let layerModuleTarget = LayerModuleTarget(moduleName,
                                                      moduleType: moduleType,
                                                      targetType: targetType)
            let options = targetOptions[.targetTypeToOptionType(targetType)] ?? targetOptions[.default] ?? LayerModuleTargetOption()
            let modulePath = layerModuleTarget.modulePath
            let targetName = layerModuleTarget.name
            let targetPath = layerModuleTarget.path
            let product = targetType.product
            
            let bundleId = options.bundleId ?? [
                organizationName,
                appName,
                moduleType.bundleIdDescription,
                moduleName,
                targetType.bundleIdDescription
            ]
                .compactMap{ !($0?.isEmpty ?? true) ? $0 : nil }
                .joined(separator: ".")
                .lowercased()
            
            let sourcesPath: Path = switch moduleType {
            case .app: targetPath.appending("Sources")
            case .diContainer,
                    .coordinator,
                    .coordinatorInterface,
                    .repositoryInterfaces,
                    .baseDomain,
                    .baseData,
                    .core,
                    .shared:
                targetPath.appending("Sources")
            case .feature, .domain, .data, .infrastructure: targetPath
            }
            
            let sources: SourceFilesList = .sourceFilesList(globs: [
                .glob(sourcesPath.appending("**"))
            ] + (options.additionalSources ?? []))
            
            
            let resourcesPath: Path? = switch moduleType {
            case .app: modulePath.appending("Resources")
            case .diContainer,
                    .coordinator,
                    .coordinatorInterface,
                    .repositoryInterfaces,
                    .core,
                    .shared: nil
            case .feature, .infrastructure: modulePath.appending("Resources")
            case  .domain, .data: nil
            case .baseDomain, .baseData: nil
            }
            
            let defaultResources: [ResourceFileElement] = {
                guard let resourcesPath else { return [] }
                return [
                    .glob(
                        pattern: resourcesPath.appending("**"),
                        excluding: [resourcesPath.appending("Info.plist")]
                    )
                ]
            }()
            

            let resources: ResourceFileElements = .resources(defaultResources + (options.additionalResources ?? []))

            let architectureTargetTypeDenpendencies = targetType.targetTypeDependences
            
            let architectureTargetDependencies: [TargetDependency] = architectureTargetTypeDenpendencies.map { targetTypeDependency in
                let dependLayerModuleTarget = LayerModuleTarget(moduleName,
                                                                moduleType: moduleType,
                                                                targetType: targetTypeDependency)
                return .target(name: dependLayerModuleTarget.name, condition: nil)
            }
            
            let layerModuleTargetDependencies: [TargetDependency] = switch targetType {
            case .interface, .coordinator:
                layerModuleDependencies.map({ layerModuleDependency in
                    if !moduleType.dependableLayerModuleTypes.contains(layerModuleDependency.moduleType) {
                        fatalError("Invalid layer dependency: this layer is not allowed to depend on the specified layer.")
                    }
                    return layerModuleDependency.toTargetDependency(targetType: .interface)
                })
            case .diContainer:
                layerModuleDependencies.map<[[TargetDependency]]> { layerModuleDependency in
                    if !moduleType.dependableLayerModuleTypes.contains(layerModuleDependency.moduleType) {
                        fatalError("Invalid layer dependency: this layer is not allowed to depend on the specified layer.")
                    }
                    return switch layerModuleDependency.moduleType {
                    case .feature, .domain, .data, .infrastructure: [
                        layerModuleDependency.toTargetDependency(targetType: .interface),
                        layerModuleDependency.toTargetDependency(targetType: .implementation)
                    ]
                    default: [
                        layerModuleDependency.toTargetDependency(targetType: .default)
                    ]
                    }
                }.flatMap { $0 }
            default: []
            }
            
            let dependencies = architectureTargetDependencies + layerModuleTargetDependencies + targetDependencies
            
            return .target(name: targetName,
                           destinations: options.destinations,
                           product: product,
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
    
    private func generateRepositoryInterfaceTargets() -> [Target] {
        let options = targetOptions[.repositoryInterface] ?? targetOptions[.default] ?? LayerModuleTargetOption()
        
        return repositoryTargetNames?.map { repositoryName in
            let layerModuleTarget = LayerModuleTarget(moduleName,
                                                      moduleType: .repositoryInterfaces,
                                                      targetType: .repositoryInterface)
            let targetName = layerModuleTarget.repositoryInterfaceName(repositoryName: repositoryName)
            let product = LayerModuleTargetType.repositoryInterface.product
            let targetPath = layerModuleTarget.repositoryInterfacePath(repositoryName: repositoryName)
            
            let bundleId = options.bundleId ?? [
                organizationName,
                appName,
                layerModuleName
            ]
                .compactMap { $0?.isEmpty == false ? $0 : nil }
                .joined(separator: ".")
                .lowercased()
            
            let sources: SourceFilesList = .sourceFilesList(globs: [
                .glob(targetPath.appending("**"))
            ] + (options.additionalSources ?? []))
            
            let resources: ResourceFileElements = .resources((options.additionalResources ?? []))
            
            return .target(name: targetName,
                           destinations: options.destinations,
                           product: product,
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
                           dependencies: options.dependencies,
                           settings: options.settings,
                           coreDataModels: options.coreDataModels,
                           environmentVariables: options.environmentVariables,
                           launchArguments: options.launchArguments,
                           additionalFiles: options.additionalFiles,
                           buildRules: options.buildRules,
                           mergedBinaryType: options.mergedBinaryType,
                           mergeable: options.mergeable)
        } ?? []
    }
}
