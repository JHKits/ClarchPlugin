//
//  app.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let appNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let appAuthorAttribute: Template.Attribute = .optional("author",
                                                       default: "nil")
let appCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                            default: "nil")
let appOrganizationAttribute: Template.Attribute = .optional("organization",
                                                             default: "nil")
let appCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                              default: "nil")


// MARK: - Utils
let appCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let appBasePathString = "App/\(appCapitalizedName)"


//MARK: - Template
let appTemplate = Template(
    description: "App Template",
    attributes: [
        appNameAttribute,
        appAuthorAttribute,
        appCurrentDateAttribute,
        appOrganizationAttribute,
        appCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(appBasePathString)/Project.swift",
              templatePath: "./stencils/app.stencil"),
        
        // Base Source Files
        .file(path: "\(appBasePathString)/Sources/App.swift",
              templatePath: "./stencils/App.swift.stencil"),
        .file(path: "\(appBasePathString)/Sources/AppDelegate.swift",
              templatePath: "./stencils/AppDelegate.swift.stencil"),
        .file(path: "\(appBasePathString)/Sources/SceneDelegate.swift",
              templatePath: "./stencils/SceneDelegate.swift.stencil"),
        
        // Base Resource Files
        .string(path: "\(appBasePathString)/Resources/empty.swift",
                contents: "// Resource")
    ]
)
