//
//  core.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let coreNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let coreAuthorAttribute: Template.Attribute = .optional("author",
                                                           default: "nil")
let coreCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                default: "nil")
let coreOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                 default: "nil")
let coreCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                  default: "nil")


// MARK: - Utils
let coreCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let coreBasePathString = "Core/Core\(coreCapitalizedName)"


//MARK: - Template
let coreTemplate = Template(
    description: "Core Template",
    attributes: [
        coreNameAttribute,
        coreAuthorAttribute,
        coreCurrentDateAttribute,
        coreOrganizationAttribute,
        coreCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(coreBasePathString)/Project.swift",
              templatePath: "./stencils/core.stencil"),
        
        // Base Source Files
        .string(path: "\(coreBasePathString)/Sources/empty.swift",
                contents: "// Source")
    ]
)
