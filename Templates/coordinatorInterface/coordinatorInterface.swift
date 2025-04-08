//
//  coordinatorInterface.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let coordinatorInterfaceNameAttribute: Template.Attribute = .optional("name", default: "")


//MARK: - Attributes for header
let coordinatorInterfaceAuthorAttribute: Template.Attribute = .optional("author",
                                                                        default: "nil")
let coordinatorInterfaceCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                             default: "nil")
let coordinatorInterfaceOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                              default: "nil")
let coordinatorInterfaceCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                               default: "nil")


// MARK: - Utils
let coordinatorInterfaceCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let coordinatorInterfaceBasePathString = "App/\(coordinatorInterfaceCapitalizedName)CoordinatorInterface"


//MARK: - Template
let coordinatorInterfaceTemplate = Template(
    description: "CoordinatorInterface Template",
    attributes: [
        coordinatorInterfaceNameAttribute,
        coordinatorInterfaceAuthorAttribute,
        coordinatorInterfaceCurrentDateAttribute,
        coordinatorInterfaceOrganizationAttribute,
        coordinatorInterfaceCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(coordinatorInterfaceBasePathString)/Project.swift",
              templatePath: "./stencils/coordinatorInterface.stencil"),
        
        // Base Source Files
        .file(path: "\(coordinatorInterfaceBasePathString)/Sources/\(dataCapitalizedName)CoordinatorInterface.swift",
              templatePath: "./stencils/CoordinatorInterface.swift.stencil")
    ]
)
