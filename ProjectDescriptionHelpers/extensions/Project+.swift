//
//  Project+.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/7/25.
//

import ProjectDescription

public extension Project {
    static func app(appName: String,
                    organizationName: String? = nil,
                    additionalTargets: [ProjectDescription.Target] = [],
                    layerModuleDependencies: [LayerModuleDependency] = [],
                    targetDependencies: [TargetDependency] = [],
                    targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                    options: ProjectDescription.Project.Options = .options(),
                    packages: [ProjectDescription.Package] = [],
                    settings: ProjectDescription.Settings? = nil,
                    schemes: [ProjectDescription.Scheme] = [],
                    fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                    additionalFiles: [ProjectDescription.FileElement] = [],
                    resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .app,
                    appName: appName,
                    moduleName: appName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func diContainer(appName: String? = nil,
                            moduleName: String = "",
                            organizationName: String? = nil,
                            additionalTargets: [ProjectDescription.Target] = [],
                            layerModuleDependencies: [LayerModuleDependency] = [],
                            targetDependencies: [TargetDependency] = [],
                            targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                            options: ProjectDescription.Project.Options = .options(),
                            packages: [ProjectDescription.Package] = [],
                            settings: ProjectDescription.Settings? = nil,
                            schemes: [ProjectDescription.Scheme] = [],
                            fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                            additionalFiles: [ProjectDescription.FileElement] = [],
                            resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .diContainer,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func coordinator(appName: String? = nil,
                            moduleName: String = "",
                            organizationName: String? = nil,
                            additionalTargets: [ProjectDescription.Target] = [],
                            layerModuleDependencies: [LayerModuleDependency] = [],
                            targetDependencies: [TargetDependency] = [],
                            targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                            options: ProjectDescription.Project.Options = .options(),
                            packages: [ProjectDescription.Package] = [],
                            settings: ProjectDescription.Settings? = nil,
                            schemes: [ProjectDescription.Scheme] = [],
                            fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                            additionalFiles: [ProjectDescription.FileElement] = [],
                            resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .coordinator,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func coordinatorInterface(appName: String? = nil,
                                     moduleName: String = "",
                                     organizationName: String? = nil,
                                     additionalTargets: [ProjectDescription.Target] = [],
                                     layerModuleDependencies: [LayerModuleDependency] = [],
                                     targetDependencies: [TargetDependency] = [],
                                     targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                                     options: ProjectDescription.Project.Options = .options(),
                                     packages: [ProjectDescription.Package] = [],
                                     settings: ProjectDescription.Settings? = nil,
                                     schemes: [ProjectDescription.Scheme] = [],
                                     fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                                     additionalFiles: [ProjectDescription.FileElement] = [],
                                     resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .coordinatorInterface,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func feature(appName: String? = nil,
                        moduleName: String,
                        organizationName: String? = nil,
                        additionalTargets: [ProjectDescription.Target] = [],
                        layerModuleDependencies: [LayerModuleDependency] = [],
                        targetDependencies: [TargetDependency] = [],
                        targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                        options: ProjectDescription.Project.Options = .options(),
                        packages: [ProjectDescription.Package] = [],
                        settings: ProjectDescription.Settings? = nil,
                        schemes: [ProjectDescription.Scheme] = [],
                        fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                        additionalFiles: [ProjectDescription.FileElement] = [],
                        resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .feature,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func domain(appName: String? = nil,
                       moduleName: String,
                       organizationName: String? = nil,
                       additionalTargets: [ProjectDescription.Target] = [],
                       layerModuleDependencies: [LayerModuleDependency] = [],
                       targetDependencies: [TargetDependency] = [],
                       targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                       options: ProjectDescription.Project.Options = .options(),
                       packages: [ProjectDescription.Package] = [],
                       settings: ProjectDescription.Settings? = nil,
                       schemes: [ProjectDescription.Scheme] = [],
                       fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                       additionalFiles: [ProjectDescription.FileElement] = [],
                       resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .domain,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func repositoryInterfaces(appName: String? = nil,
                                     moduleName: String = "",
                                     organizationName: String? = nil,
                                     repositoryTargetNames: [String],
                                     additionalTargets: [ProjectDescription.Target] = [],
                                     layerModuleDependencies: [LayerModuleDependency] = [],
                                     targetDependencies: [TargetDependency] = [],
                                     targetOptions: [LayerModuleTargetSelection : LayerModuleTargetOption] = [:],
                                     options: ProjectDescription.Project.Options = .options(),
                                     packages: [ProjectDescription.Package] = [],
                                     settings: ProjectDescription.Settings? = nil,
                                     schemes: [ProjectDescription.Scheme] = [],
                                     fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                                     additionalFiles: [ProjectDescription.FileElement] = [],
                                     resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .repositoryInterfaces,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    repositoryTargetNames: repositoryTargetNames,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func baseDomain(appName: String? = nil,
                           moduleName: String = "",
                           organizationName: String? = nil,
                           additionalTargets: [ProjectDescription.Target] = [],
                           layerModuleDependencies: [LayerModuleDependency] = [],
                           targetDependencies: [TargetDependency] = [],
                           targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                           options: ProjectDescription.Project.Options = .options(),
                           packages: [ProjectDescription.Package] = [],
                           settings: ProjectDescription.Settings? = nil,
                           schemes: [ProjectDescription.Scheme] = [],
                           fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                           additionalFiles: [ProjectDescription.FileElement] = [],
                           resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .baseDomain,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func data(appName: String? = nil,
                     moduleName: String,
                     organizationName: String? = nil,
                     additionalTargets: [ProjectDescription.Target] = [],
                     layerModuleDependencies: [LayerModuleDependency] = [],
                     targetDependencies: [TargetDependency] = [],
                     targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                     options: ProjectDescription.Project.Options = .options(),
                     packages: [ProjectDescription.Package] = [],
                     settings: ProjectDescription.Settings? = nil,
                     schemes: [ProjectDescription.Scheme] = [],
                     fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                     additionalFiles: [ProjectDescription.FileElement] = [],
                     resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .data,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func baseData(appName: String? = nil,
                         moduleName: String = "",
                         organizationName: String? = nil,
                         additionalTargets: [ProjectDescription.Target] = [],
                         layerModuleDependencies: [LayerModuleDependency] = [],
                         targetDependencies: [TargetDependency] = [],
                         targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                         options: ProjectDescription.Project.Options = .options(),
                         packages: [ProjectDescription.Package] = [],
                         settings: ProjectDescription.Settings? = nil,
                         schemes: [ProjectDescription.Scheme] = [],
                         fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                         additionalFiles: [ProjectDescription.FileElement] = [],
                         resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .baseData,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func infrastructure(appName: String? = nil,
                               moduleName: String,
                               organizationName: String? = nil,
                               additionalTargets: [ProjectDescription.Target] = [],
                               layerModuleDependencies: [LayerModuleDependency] = [],
                               targetDependencies: [TargetDependency] = [],
                               targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                               options: ProjectDescription.Project.Options = .options(),
                               packages: [ProjectDescription.Package] = [],
                               settings: ProjectDescription.Settings? = nil,
                               schemes: [ProjectDescription.Scheme] = [],
                               fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                               additionalFiles: [ProjectDescription.FileElement] = [],
                               resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .infrastructure,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func core(appName: String? = nil,
                     moduleName: String,
                     organizationName: String? = nil,
                     additionalTargets: [ProjectDescription.Target] = [],
                     layerModuleDependencies: [LayerModuleDependency] = [],
                     targetDependencies: [TargetDependency] = [],
                     targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                     options: ProjectDescription.Project.Options = .options(),
                     packages: [ProjectDescription.Package] = [],
                     settings: ProjectDescription.Settings? = nil,
                     schemes: [ProjectDescription.Scheme] = [],
                     fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                     additionalFiles: [ProjectDescription.FileElement] = [],
                     resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .core,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
    static func shared(appName: String? = nil,
                       moduleName: String,
                       organizationName: String? = nil,
                       additionalTargets: [ProjectDescription.Target] = [],
                       layerModuleDependencies: [LayerModuleDependency] = [],
                       targetDependencies: [TargetDependency] = [],
                       targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption] = [:],
                       options: ProjectDescription.Project.Options = .options(),
                       packages: [ProjectDescription.Package] = [],
                       settings: ProjectDescription.Settings? = nil,
                       schemes: [ProjectDescription.Scheme] = [],
                       fileHeaderTemplate: ProjectDescription.FileHeaderTemplate? = nil,
                       additionalFiles: [ProjectDescription.FileElement] = [],
                       resourceSynthesizers: [ProjectDescription.ResourceSynthesizer] = .default) -> Self {
        LayerModule(moduleType: .shared,
                    appName: appName,
                    moduleName: moduleName,
                    organizationName: organizationName,
                    additionalTargets: additionalTargets,
                    layerModuleDependencies: layerModuleDependencies,
                    targetDependencies: targetDependencies,
                    targetOptions: targetOptions,
                    options: options,
                    packages: packages,
                    settings: settings,
                    schemes: schemes,
                    fileHeaderTemplate: fileHeaderTemplate,
                    additionalFiles: additionalFiles,
                    resourceSynthesizers: resourceSynthesizers)
        .toProject()
    }
    
}
