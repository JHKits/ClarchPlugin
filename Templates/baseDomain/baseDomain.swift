//
//  baseDomain.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let baseDomainNameAttribute: Template.Attribute = .optional("name", default: "")


//MARK: - Attributes for header
let baseDomainAuthorAttribute: Template.Attribute = .optional("author",
                                                              default: "nil")
let baseDomainCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                   default: "nil")
let baseDomainOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                    default: "nil")
let baseDomainCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                     default: "nil")


// MARK: - Utils
let baseDomainCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let baseDomainBasePathString = "Domain/\(baseDomainCapitalizedName)BaseDomain"


//MARK: - Template
let baseDomainTemplate = Template(
    description: "BaseDomain Template",
    attributes: [
        baseDomainNameAttribute,
        baseDomainAuthorAttribute,
        baseDomainCurrentDateAttribute,
        baseDomainOrganizationAttribute,
        baseDomainCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(baseDomainBasePathString)/Project.swift",
              templatePath: "./stencils/baseDomain.stencil"),
        
        // Base Source Files
        .string(path: "\(baseDomainBasePathString)/Sources/empty.swift",
                contents: "// Source")
    ]
)
