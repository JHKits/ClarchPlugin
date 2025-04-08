//
//  baseData.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let baseDataNameAttribute: Template.Attribute = .optional("name", default: "")


//MARK: - Attributes for header
let baseDataAuthorAttribute: Template.Attribute = .optional("author",
                                                            default: "nil")
let baseDataCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                 default: "nil")
let baseDataOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                  default: "nil")
let baseDataCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                   default: "nil")


// MARK: - Utils
let baseDataCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let baseDataBasePathString = "Data/\(baseDataCapitalizedName)BaseData"


//MARK: - Template
let baseDataTemplate = Template(
    description: "BaseData Template",
    attributes: [
        baseDataNameAttribute,
        baseDataAuthorAttribute,
        baseDataCurrentDateAttribute,
        baseDataOrganizationAttribute,
        baseDataCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(baseDataBasePathString)/Project.swift",
              templatePath: "./stencils/baseData.stencil"),
        
        // Base Source Files
        .string(path: "\(baseDataBasePathString)/Sources/empty.swift",
                contents: "// Source")
    ]
)
