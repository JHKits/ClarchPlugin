//
//  Path+.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 4/6/25.
//

import ProjectDescription

extension Path {
    func appending(_ path: String) -> Path {
        let newPath = "\(self.pathString)/\(path)"
            .replacingOccurrences(of: "//", with: "/")
        return switch self.type{
        case .relativeToCurrentFile: .relativeToCurrentFile(newPath)
        case .relativeToManifest: .relativeToManifest(newPath)
        case .relativeToRoot: .relativeToRoot(newPath)
        default: .init(stringLiteral: newPath)
        }
    }
}
