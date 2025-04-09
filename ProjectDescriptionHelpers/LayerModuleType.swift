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
    public var bundleIdDescription: String {
        return switch self {
        case .app, .diContainer, .coordinator, .coordinatorInterface: "app"
        case .feature: "feature"
        case .domain, .repositoryInterfaces, .baseDomain: "domain"
        case .data, .baseData: "data"
        case .infrastructure: "infrastructure"
        case .core: "core"
        case .shared: "shared"
        }
    }
    
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
    
    public var dependableLayerModuleTypes: Set<LayerModuleType> {
        let dependables: Set<LayerModuleType> = switch self {
        case .app: [.diContainer, .coordinatorInterface]
        case .diContainer: Set(LayerModuleType.allCases.filter { ![.app, .diContainer].contains($0) })
        case .coordinator: [.coordinatorInterface, .feature]
        case .coordinatorInterface: []
        case .feature: [.coordinatorInterface, .domain]
        case .domain: [.baseDomain, .repositoryInterfaces, .data]
        case .repositoryInterfaces: []
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
        case .diContainer: [.diContainer]
        case .coordinator: [.coordinator]
        case .coordinatorInterface: [.coordinatorInterface]
        case .feature: [.interface, .implementation, .example]
        case .domain: [.interface, .implementation, .testing, .unitTests]
        case .repositoryInterfaces: [.repositoryInterface]
        case .baseDomain: [.sources]
        case .data: [.interface, .implementation, .testing, .unitTests]
        case .baseData: [.sources]
        case .infrastructure: [.interface, .implementation, .testing, .unitTests]
        case .core: [.sources]
        case .shared: [.sources]
        }
    }
}
