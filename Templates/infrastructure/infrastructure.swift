//
//  infrastructure.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let infrastructureNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let infrastructureAuthorAttribute: Template.Attribute = .optional("author",
                                                        default: "nil")
let infrastructureCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                             default: "nil")
let infrastructureOrganizationAttribute: Template.Attribute = .optional("organization",
                                                              default: "nil")
let infrastructureCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                               default: "nil")


// MARK: - Utils
let infrastructureCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let infrastructureBasePathString = "Infrastructure/\(infrastructureCapitalizedName)Infrastructure"


//MARK: - Template
let infrastructureTemplate = Template(
    description: "Infrastructure Template",
    attributes: [
        infrastructureNameAttribute,
        infrastructureAuthorAttribute,
        infrastructureCurrentDateAttribute,
        infrastructureOrganizationAttribute,
        infrastructureCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(infrastructureBasePathString)/Project.swift",
              templatePath: "./stencils/infrastructure.stencil"),
        
        // Base Source Files
        .file(path: "\(infrastructureBasePathString)/Interface/\(infrastructureCapitalizedName)ServiceInterface.swift",
              templatePath: "./stencils/ServiceInterface.swift.stencil"),
        .file(path: "\(infrastructureBasePathString)/Implementation/\(infrastructureCapitalizedName)Service.swift",
              templatePath: "./stencils/Service.swift.stencil"),
        .file(path: "\(infrastructureBasePathString)/Tests/\(infrastructureCapitalizedName)ServiceTests.swift",
              templatePath: "./stencils/ServiceTests.swift.stencil"),
    ]
)
