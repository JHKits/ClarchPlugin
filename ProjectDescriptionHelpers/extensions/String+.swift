//
//  String+.swift
//  ClarchPlugin
//
//  Created by Jeonhui on 3/20/25.
//

extension String {
    var capitalizedFirst: String {
        prefix(1).capitalized + dropFirst()
    }
    
    var lowercasedFirst: String {
        prefix(1).lowercased() + dropFirst()
    }
}
