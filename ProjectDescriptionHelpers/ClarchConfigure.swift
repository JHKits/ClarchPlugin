//
//  ClarchConfiguration.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

public final class ClarchConfiguration {
    private static let pathStrings: [String] = [
        "App/**",
        "Feature/**",
        "Domain/**",
        "Data/**",
        "Infrastructure/**",
        "Core/**",
        "Shared/**"
    ]
    
    public static var workspacePaths: [ProjectDescription.Path] {
        pathStrings.map { pathString in
            .relativeToRoot(pathString)
        }
    }
}
