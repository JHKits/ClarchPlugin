//
//  LayerModuleDependency.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/7/25.
//

import ProjectDescription

public enum LayerModuleDependencyTargetType: Equatable {
    case `default`
    case app
    case sources
    case repositoryInterface(_ repositoryName: String)
    
    case interface
    case implementation
    case testing
    case example
    case tests
    
    func toTargetType(moduleType: LayerModuleType) -> LayerModuleTargetType {
        return switch self {
        case .default:
            switch moduleType {
            case .app: .app
            case .diContainer,
                    .coordinator,
                    .coordinatorInterface,
                    .baseDomain,
                    .baseData,
                    .core,
                    .shared: .sources
            case .repositoryInterfaces:
                fatalError("`.repositoryInterfaces` cannot be used with `.default`.")
            case .feature, .domain, .data, .infrastructure: .interface
            }
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

public struct LayerModuleDependency {
    let moduleName: String
    let moduleType: LayerModuleType
    let repositoryName: String?
    let condition: PlatformCondition?
    
    public init(moduleName: String,
                moduleType: LayerModuleType,
                condition: PlatformCondition? = nil) {
        self.moduleName = moduleName.capitalizedFirst
        self.moduleType = moduleType
        self.repositoryName = nil
        self.condition = condition
    }
    
    public init(moduleName: String,
                repositoryName: String,
                condition: PlatformCondition? = nil) {
        self.moduleName = moduleName.capitalizedFirst
        self.moduleType = .repositoryInterfaces
        self.repositoryName = repositoryName
        self.condition = condition
    }
    
    public static func diContainer(moduleName: String = "",
                                   condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .diContainer, condition: condition)
    }
    
    public static func coordinator(moduleName: String = "",
                                   condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinator, condition: condition)
    }
    
    public static func coordinatorInterface(moduleName: String = "",
                                            condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinatorInterface, condition: condition)
    }
    
    public static func feature(moduleName: String,
                               condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .feature, condition: condition)
    }
    
    
    public static func domain(moduleName: String,
                              condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .domain, condition: condition)
    }
    
    public static func repositoryInterfaces(moduleName: String = "",
                                            repositoryName: String,
                                            condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, repositoryName: repositoryName, condition: condition)
    }
    
    public static func baseDomain(moduleName: String = "",
                                  condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseDomain, condition: condition)
    }
    
    public static func data(moduleName: String,
                            condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .data, condition: condition)
    }
    
    public static func baseData(moduleName: String = "",
                                condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseData, condition: condition)
    }
    
    public static func infrastructure(moduleName: String,
                                      condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .infrastructure, condition: condition)
    }
    
    public static func core(moduleName: String,
                            condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .core, condition: condition)
    }
    
    public static func shared(moduleName: String,
                              condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .shared, condition: condition)
    }
    
    public func toDIContainrTargetDependencies() -> [TargetDependency] {
        return switch moduleType {
        case .feature, .domain, .data, .infrastructure:
            [
                toTargetDependency(targetType: .interface),
                toTargetDependency(targetType: .implementation)
            ]
        default:[toTargetDependency(targetType: .default)]
        }
    }
    
    public func toTestsTargetDependencies() -> [TargetDependency] {
        return switch moduleType {
        case .feature, .domain, .data:
            [
                toTargetDependency(targetType: .interface),
                toTargetDependency(targetType: .implementation),
                toTargetDependency(targetType: .testing)
            ]
        case .infrastructure:
            [
                toTargetDependency(targetType: .interface),
                toTargetDependency(targetType: .implementation),
            ]
        default:[toTargetDependency(targetType: .default)]
        }
    }
    
    public func toTargetDependency(targetType: LayerModuleDependencyTargetType = .default) -> TargetDependency {
        if (moduleType == .repositoryInterfaces && targetType == .default) {
            guard let repositoryName = repositoryName else {
                fatalError("`.repositoryInterfaces` cannot be used with `.default`.")
            }
            let target = LayerModuleTarget(moduleName,
                                           moduleType: moduleType,
                                           targetType: .repositoryInterface(repositoryName))
            return .project(target: target.name,
                            path: target.modulePath,
                            condition: condition)
        }
        let target = LayerModuleTarget(moduleName,
                                       moduleType: moduleType,
                                       targetType: targetType.toTargetType(moduleType: moduleType))
        return .project(target: target.name,
                        path: target.modulePath,
                        condition: condition)
    }
}
