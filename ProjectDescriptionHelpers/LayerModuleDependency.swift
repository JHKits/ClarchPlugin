//
//  LayerModuleDependency.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/7/25.
//

import ProjectDescription

public enum LayerModuleDependencyType {
    case `default`
    case interface
    case implementation
    case testing
    case example
    case uiTests
    case unitTests
    
    public func toLayerModuleTargetType(moduleType: LayerModuleType) -> LayerModuleTargetType {
        return switch self {
        case .default:
            switch moduleType {
            case .feature, .domain, .data, .infrastructure: .interface
            case .app: .app
            case .diContainer: .diContainer
            case .coordinator: .coordinator
            case .coordinatorInterface: .coordinatorInterface
            case .repositoryInterfaces: .repositoryInterface
            case .baseDomain, .baseData: .sources
            case .core, .shared: .sources
            }
        case .interface: .interface
        case .implementation: .implementation
        case .testing: .testing
        case .example: .example
        case .uiTests: .uiTests
        case .unitTests: .unitTests
        }
    }
}

public struct LayerModuleDependency {
    let moduleName: String
    let moduleType: LayerModuleType
    private let repositoryName: String?
    
    public init(moduleName: String, moduleType: LayerModuleType) {
        self.moduleName = moduleName.capitalizedFirst
        self.moduleType = moduleType
        self.repositoryName = nil
    }
    
    public init(moduleName: String, repositoryName: String) {
        self.moduleName = moduleName.capitalizedFirst
        self.repositoryName = repositoryName
        self.moduleType = .repositoryInterfaces
    }
    
    public static func diContainer(moduleName: String = "") -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .diContainer)
    }
    
    public static func coordinator(moduleName: String = "") -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinator)
    }
    
    public static func coordinatorInterface(moduleName: String = "") -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinatorInterface)
    }
    
    public static func feature(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .feature)
    }
    
    
    public static func domain(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .domain)
    }
    
    public static func repositoryInterfaces(moduleName: String = "",
                                            repositoryName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, repositoryName: repositoryName)
    }
    
    public static func baseDomain(moduleName: String = "") -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseDomain)
    }
    
    public static func data(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .data)
    }
    
    public static func baseData(moduleName: String = "") -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseData)
    }
    
    public static func infrastructure(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .infrastructure)
    }
    
    public static func core(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .core)
    }
    
    public static func shared(moduleName: String) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .shared)
    }
    
    func toTargetDependency(targetType: LayerModuleDependencyType = .default,
                            condition: PlatformCondition? = nil) -> TargetDependency {
        
        let target = LayerModuleTarget(moduleName,
                                       moduleType: moduleType,
                                       targetType: targetType.toLayerModuleTargetType(moduleType: moduleType))
        if moduleType == .repositoryInterfaces {
            guard let repositoryName = repositoryName else {
                fatalError("A repositoryName is required for .repositoryInterfaces")
            }
            return .project(target: target.repositoryInterfaceName(repositoryName: repositoryName),
                            path: target.modulePath,
                            condition: condition)
        }
        return .project(target: target.name,
                        path: target.modulePath,
                        condition: condition)
    }
}
