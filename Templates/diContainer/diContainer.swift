//
//  diContainer.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let diContainerNameAttribute: Template.Attribute = .optional("name", default: "")


//MARK: - Attributes for header
let diContainerAuthorAttribute: Template.Attribute = .optional("author",
                                                               default: "nil")
let diContainerCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                    default: "nil")
let diContainerOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                     default: "nil")
let diContainerCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                      default: "nil")


// MARK: - Utils
let diContainerCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let diContainerBasePathString = "App/\(diContainerCapitalizedName)DIContainer"


//MARK: - Template
let diContainerTemplate = Template(
    description: "DIContainer Template",
    attributes: [
        diContainerNameAttribute,
        diContainerAuthorAttribute,
        diContainerCurrentDateAttribute,
        diContainerOrganizationAttribute,
        diContainerCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(diContainerBasePathString)/Project.swift",
              templatePath: "./stencils/diContainer.stencil"),
        
        // Base Source Files
        .file(path: "\(diContainerBasePathString)/Sources/\(diContainerCapitalizedName)DIContainer.swift",
              templatePath: "./stencils/DIContainer.swift.stencil")
    ]
)
