//
//  LayerModuleTarget.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/4/25.
//

import ProjectDescription


public enum LayerModuleTargetType: String, CaseIterable {
    case app
    case coordinator
    case coordinatorInterface
    case diContainer
    case repositoryInterface
    case sources
    
    case interface
    case implementation
    case testing
    case example
    case uiTests
    case unitTests
    
    // MARK: - Computed Vars
    public var directoryName: String {
        return self.rawValue.capitalizedFirst
    }
    
    public var product: Product {
        return switch self {
        case .app: .app
        case .diContainer, .coordinator, .coordinatorInterface, .repositoryInterface: .staticFramework
        case .interface, .implementation, .testing: .staticFramework
        case .example: .app
        case .uiTests: .uiTests
        case .unitTests: .unitTests
        case .sources: .staticFramework
        }
    }
    
    public var targetTypeDependences: [LayerModuleTargetType] {
        return switch self {
        case .app: []
        case .diContainer, .coordinator, .coordinatorInterface, .repositoryInterface: []
        case .interface: []
        case .implementation: [.interface]
        case .testing: [.interface]
        case .example: [.implementation]
        case .uiTests: [.testing, .implementation]
        case .unitTests: [.testing, .implementation]
        case .sources: []
        }
    }
    
    public var bundleIdDescription: String? {
        switch self{
        case .app, .diContainer, .coordinator, .coordinatorInterface, .repositoryInterface, .sources: nil
        default:
            self.rawValue.lowercased()
        }
    }
}

public struct LayerModuleTarget {
    let moduleName: String
    let moduleType: LayerModuleType
    let targetType: LayerModuleTargetType
    
    init(_ moduleName: String,
         moduleType: LayerModuleType,
         targetType: LayerModuleTargetType) {
        self.moduleName = moduleName
        self.moduleType = moduleType
        self.targetType = targetType
    }
    
    private var layerModuleName: String {
        switch moduleType {
        case .app: "\(moduleName)"
        case .diContainer: "\(moduleName)DIContainer"
        case .core, .shared: "\(moduleType.rawValue.capitalizedFirst)\(moduleName)"
        default: "\(moduleName)\(moduleType.rawValue.capitalizedFirst)"
        }
    }
    
    var name: String {
        return switch moduleType {
        case .app, .diContainer, .coordinator, .coordinatorInterface:
            "\(layerModuleName)"
        case .repositoryInterfaces:
            fatalError("Use repositoryInterfaceTargetPath for .repositoryInterfaces. (\(layerModuleName))")
        case .feature, .domain, .data, .infrastructure:
            "\(layerModuleName)\(targetType.rawValue.capitalizedFirst)"
        case .core, .shared:
            "\(layerModuleName)"
        case .baseDomain, .baseData:"\(layerModuleName)"
        }
    }
    
    var modulePath: ProjectDescription.Path {
        let dirs = switch moduleType {
        case .app, .diContainer, .coordinator, .coordinatorInterface:
            [moduleType.directoryName, layerModuleName]
        case .repositoryInterfaces:
            fatalError("Use repositoryInterfaceTargetPath for .repositoryInterfaces. (\(layerModuleName))")
        case .feature, .domain, .data, .infrastructure, .core, .shared, .baseDomain, .baseData:
            [moduleType.directoryName,
             layerModuleName]
        }
        return .relativeToRoot(dirs.joined(separator: "/"))
    }
    
    var path: ProjectDescription.Path {
        switch moduleType {
        case .app, .diContainer, .coordinator, .coordinatorInterface, .core, .shared, .baseDomain, .baseData:
            return modulePath
        case .repositoryInterfaces:
            fatalError("Use repositoryInterfaceTargetPath for .repositoryInterfaces. (\(layerModuleName))")
        case .feature, .domain, .data, .infrastructure:
            return modulePath.appending(targetType.directoryName)
        }
    }
    
    func repositoryInterfaceName(repositoryName: String) -> String {
        guard moduleType == .repositoryInterfaces else {
            fatalError("Only used for .repositoryInterfaces (\(layerModuleName))")
        }
        return "\(repositoryName)RepositoryInterface"
    }
    
    func repositoryInterfacePath(repositoryName: String) -> Path {
        guard moduleType == .repositoryInterfaces else {
            fatalError("Only used for .repositoryInterfaces (\(layerModuleName))")
        }
        let dirs = [moduleType.directoryName,
                    layerModuleName,
                    repositoryInterfaceName(repositoryName: repositoryName)]
        return .relativeToRoot(dirs.joined(separator: "/"))
    }
}

public enum LayerModuleTargetOptionType {
    case `default`
    case app
    case coordinator
    case coordinatorInterface
    case diContainer
    case repositoryInterface
    case sources
    
    case interface
    case implementation
    case testing
    case example
    case uiTests
    case unitTests
    
    static func targetTypeToOptionType(_ targetType: LayerModuleTargetType) -> Self {
        return switch targetType {
        case .app: .app
        case .coordinator: .coordinator
        case .coordinatorInterface: .coordinatorInterface
        case .diContainer: .diContainer
        case .repositoryInterface: .repositoryInterface
        case .sources: .sources
        case .interface: .interface
        case .implementation: .implementation
        case .testing: .testing
        case .example: .example
        case .uiTests: .uiTests
        case .unitTests: .unitTests
        }
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
