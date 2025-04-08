//
//  shared.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let sharedNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let sharedAuthorAttribute: Template.Attribute = .optional("author",
                                                           default: "nil")
let sharedCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                default: "nil")
let sharedOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                 default: "nil")
let sharedCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                  default: "nil")


// MARK: - Utils
let sharedCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let sharedBasePathString = "Shared/Shared\(sharedCapitalizedName)"


//MARK: - Template
let sharedTemplate = Template(
    description: "Shared Template",
    attributes: [
        sharedNameAttribute,
        sharedAuthorAttribute,
        sharedCurrentDateAttribute,
        sharedOrganizationAttribute,
        sharedCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(sharedBasePathString)/Project.swift",
              templatePath: "./stencils/shared.stencil"),
        
        // Base Source Files
        .string(path: "\(sharedBasePathString)/Sources/empty.swift",
                contents: "// Source")
    ]
)
