//
//  LayerModuleType.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/4/25.
//

import ProjectDescription


public enum LayerModuleType: String, CaseIterable {
    // MARK: - App Layer
    case app
    case diContainer
    case coordinator
    case coordinatorInterface
    
    // MARK: - Feature Layer
    case feature
    
    // MARK: - Domain Layer
    case domain
    case repositoryInterfaces
    case baseDomain
    
    // MARK: - Data Layer
    case data
    case baseData
    
    // MARK: - Infrastructure Layer
    case infrastructure
    
    // MARK: - Additional Layer
    case core
    case shared
    
    // MARK: - Computed Vars
    public var directoryName: String {
        return switch self {
        case .app, .diContainer, .coordinator, .coordinatorInterface: "App"
        case .feature: "Feature"
        case .domain, .repositoryInterfaces, .baseDomain: "Domain"
        case .data, .baseData: "Data"
        case .infrastructure: "Infrastructure"
        case .core: "Core"
        case .shared: "Shared"
        }
    }
    
    public var bundleIdDescription: String {
        return directoryName.lowercased()
    }
    
    public var dependableLayerModuleTypes: Set<LayerModuleType> {
        let dependables: Set<LayerModuleType> = switch self {
        case .app: [.diContainer, .coordinatorInterface]
        case .diContainer: Set(LayerModuleType.allCases.filter { ![.app, .diContainer].contains($0) })
        case .coordinator: [.coordinatorInterface, .feature]
        case .coordinatorInterface: []
        case .feature: [.coordinatorInterface, .domain]
        case .domain: [.baseDomain, .repositoryInterfaces]
        case .repositoryInterfaces: [.baseDomain]
        case .baseDomain: []
        case .data: [.baseData, .repositoryInterfaces, .infrastructure]
        case .baseData: []
        case .infrastructure: []
        case .core, .shared: []
        }
        return dependables.union([.core, .shared])
    }
    
    public var layerModuleTargets: Set<LayerModuleTargetType> {
        return switch self {
        case .app: [.app]
        case .diContainer: [.sources]
        case .coordinator: [.sources]
        case .coordinatorInterface: [.sources]
        case .feature: [.interface, .implementation, .testing, .tests, .example]
        case .domain: [.interface, .implementation, .testing, .tests]
        case .repositoryInterfaces: [.sources]
        case .baseDomain: [.sources]
        case .data: [.interface, .implementation, .testing, .tests]
        case .baseData: [.sources]
        case .infrastructure: [.interface, .implementation, .tests]
        case .core: [.sources]
        case .shared: [.sources]
        }
    }
}
