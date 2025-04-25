//
//  coordinator.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let coordinatorNameAttribute: Template.Attribute = .optional("name", default: "")


//MARK: - Attributes for header
let coordinatorAuthorAttribute: Template.Attribute = .optional("author",
                                                               default: "nil")
let coordinatorCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                    default: "nil")
let coordinatorOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                     default: "nil")
let coordinatorCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                      default: "nil")


// MARK: - Utils
let coordinatorCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let coordinatorBasePathString = "App/\(coordinatorCapitalizedName)Coordinator"


//MARK: - Template
let coordinatorTemplate = Template(
    description: "Coordinator Template",
    attributes: [
        coordinatorNameAttribute,
        coordinatorAuthorAttribute,
        coordinatorCurrentDateAttribute,
        coordinatorOrganizationAttribute,
        coordinatorCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(coordinatorBasePathString)/Project.swift",
              templatePath: "./stencils/coordinator.stencil"),
        
        // Base Source Files
        .file(path: "\(coordinatorBasePathString)/Sources/\(coordinatorCapitalizedName)Coordinator.swift",
              templatePath: "./stencils/Coordinator.swift.stencil")
    ]
)
