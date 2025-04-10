//
//  data.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let dataNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let dataAuthorAttribute: Template.Attribute = .optional("author",
                                                        default: "nil")
let dataCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                             default: "nil")
let dataOrganizationAttribute: Template.Attribute = .optional("organization",
                                                              default: "nil")
let dataCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                               default: "nil")


// MARK: - Utils
let dataCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let dataBasePathString = "Data/\(dataCapitalizedName)Data"


//MARK: - Template
let dataTemplate = Template(
    description: "Data Template",
    attributes: [
        dataNameAttribute,
        dataAuthorAttribute,
        dataCurrentDateAttribute,
        dataOrganizationAttribute,
        dataCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(dataBasePathString)/Project.swift",
              templatePath: "./stencils/data.stencil"),
        
        // Base Source Files
        .file(path: "\(dataBasePathString)/Interface/Sources/\(dataCapitalizedName)RepositoryInterface.swift",
              templatePath: "./stencils/RepositoryInterface.swift.stencil"),
        .file(path: "\(dataBasePathString)/Implementation/Sources/\(dataCapitalizedName)Repository.swift",
              templatePath: "./stencils/Repository.swift.stencil"),
        .file(path: "\(dataBasePathString)/Testing/Sources/Testing\(dataCapitalizedName)Service.swift",
              templatePath: "./stencils/TestingService.swift.stencil"),
        .file(path: "\(dataBasePathString)/Tests/Sources/\(dataCapitalizedName)RepositoryTests.swift",
              templatePath: "./stencils/RepositoryTests.swift.stencil"),
    ]
)
