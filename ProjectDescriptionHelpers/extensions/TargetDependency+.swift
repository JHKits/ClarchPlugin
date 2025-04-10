//
//  TargetDependency+.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/7/25.
//

import ProjectDescription

public extension TargetDependency {
    static func diContainer(moduleName: String = "",
                            condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .diContainer, condition: condition)
            .toTargetDependency(targetType: .default)
    }
    
    static func coordinator(moduleName: String = "",
                                     condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinator, condition: condition)
            .toTargetDependency(targetType: .default)
    }
    
    static func coordinatorInterface(moduleName: String = "",
                                     condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinatorInterface, condition: condition)
            .toTargetDependency(targetType: .default)
    }
    
    static func feature(moduleName: String,
                        targetType: LayerModuleDependencyTargetType = .default,
                        condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .feature, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
    
    static func domain(moduleName: String,
                       targetType: LayerModuleDependencyTargetType = .default,
                       condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .domain, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
    
    static func baseDomain(moduleName: String = "",
                           condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseDomain, condition: condition)
            .toTargetDependency(targetType: .default)
    }
    
    static func repositoryInterfaces(moduleName: String = "",
                                     repositoryName: String,
                                     condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, repositoryName: repositoryName, condition: condition)
            .toTargetDependency()
    }
    
    static func data(moduleName: String,
                     targetType: LayerModuleDependencyTargetType = .default,
                     condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .data, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
    
    static func baseData(moduleName: String = "",
                         condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseData, condition: condition)
            .toTargetDependency(targetType: .default)
    }
    
    static func infrastructure(moduleName: String,
                               targetType: LayerModuleDependencyTargetType = .default,
                               condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .infrastructure, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
    
    static func core(moduleName: String,
                     targetType: LayerModuleDependencyTargetType = .default,
                     condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .core, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
    
    static func shared(moduleName: String,
                       targetType: LayerModuleDependencyTargetType = .default,
                       condition: PlatformCondition? = nil) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .shared, condition: condition)
            .toTargetDependency(targetType: targetType)
    }
}
