//
//  TargetDependency+.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/7/25.
//

import ProjectDescription

public extension TargetDependency {
    static func diContainer(moduleName: String = "",
                            condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .diContainer)
            .toTargetDependency(targetType: .default, condition: condition)
    }
    
    static func coordinator(moduleName: String = "",
                                     condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinator)
            .toTargetDependency(targetType: .default, condition: condition)
    }
    
    static func coordinatorInterface(moduleName: String = "",
                                     condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .coordinatorInterface)
            .toTargetDependency(targetType: .default, condition: condition)
    }
    
    static func feature(moduleName: String,
                        targetType: LayerModuleDependencyType = .default,
                        condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .feature)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
    
    static func domain(moduleName: String,
                       targetType: LayerModuleDependencyType = .default,
                       condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .domain)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
    
    static func baseDomain(moduleName: String = "",
                           condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseDomain)
            .toTargetDependency(targetType: .default, condition: condition)
    }
    
    static func repositoryInterfaces(moduleName: String = "",
                                     repositoryName: String,
                                     condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, repositoryName: repositoryName)
            .toTargetDependency(condition: condition)
    }
    
    static func data(moduleName: String,
                     targetType: LayerModuleDependencyType = .default,
                     condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .data)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
    
    static func baseData(moduleName: String = "",
                         condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .baseData)
            .toTargetDependency(targetType: .default, condition: condition)
    }
    
    static func infrastructure(moduleName: String,
                               targetType: LayerModuleDependencyType = .default,
                               condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .infrastructure)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
    
    static func core(moduleName: String,
                     targetType: LayerModuleDependencyType = .default,
                     condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .core)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
    
    static func shared(moduleName: String,
                       targetType: LayerModuleDependencyType = .default,
                       condition: PlatformCondition) -> Self {
        LayerModuleDependency(moduleName: moduleName, moduleType: .shared)
            .toTargetDependency(targetType: targetType, condition: condition)
    }
}
