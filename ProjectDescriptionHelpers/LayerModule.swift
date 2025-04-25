//
//  LayerModule.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/4/25.
//

import ProjectDescription

public enum LayerModuleTargetSelection: Hashable  {
    case `default`
    case app
    case sources
    case repositoryInterface(_ repositoryName: String)
    
    case interface
    case implementation
    case testing
    case example
    case tests
}

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
    let targetOptions: [LayerModuleTargetSelection: LayerModuleTargetOption]
    
    var projectName: String {
        switch moduleType {
        case .app: "\(moduleName)"
        case .diContainer: "\(moduleName)DIContainer"
        case .core, .shared: "\(moduleType.rawValue.capitalizedFirst)\(moduleName)"
        default: "\(moduleName)\(moduleType.rawValue.capitalizedFirst)"
        }
    }
    
    public init(moduleType: LayerModuleType,
                appName: String?,
                moduleName: String,
                organizationName: String? = nil,
                repositoryTargetNames: [String]? = nil,
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
        let targets = generateLayerModuleTargets()
        return Project(name: projectName,
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
    private func generateLayerModuleTargets() -> [Target] {
        switch moduleType {
        case .repositoryInterfaces:
            return repositoryTargetNames?.map { repositoryName in
                return generateTarget(.repositoryInterface(repositoryName),
                                      targetType: .repositoryInterface(repositoryName))
            } ?? []
        default:
            return moduleType.layerModuleTargets.map { targetType in
                return generateTarget(targetType.toSelection(),
                                      targetType: targetType)
            }
        }
        
    }
    
    private func generateTarget(_ selection: LayerModuleTargetSelection,
                                targetType: LayerModuleTargetType) -> Target {
        let options = targetOptions[targetType.toSelection()] ?? targetOptions[.default] ?? LayerModuleTargetOption()
        let layerModuleTarget = LayerModuleTarget(moduleName,
                                                  moduleType: moduleType,
                                                  targetType: targetType)
        return layerModuleTarget.toTarget(appName: appName,
                                          organizationName: organizationName,
                                          options: options,
                                          layerModuleDependencies: layerModuleDependencies,
                                          targetDependencies: targetDependencies)
    }
}
