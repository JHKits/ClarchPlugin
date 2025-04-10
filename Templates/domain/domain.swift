//
//  domain.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let domainNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let domainAuthorAttribute: Template.Attribute = .optional("author",
                                                          default: "nil")
let domainCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                               default: "nil")
let domainOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                default: "nil")
let domainCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                 default: "nil")


// MARK: - Utils
let domainCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let domainBasePathString = "Domain/\(domainCapitalizedName)Domain"


//MARK: - Template
let domainTemplate = Template(
    description: "Domain Template",
    attributes: [
        domainNameAttribute,
        domainAuthorAttribute,
        domainCurrentDateAttribute,
        domainOrganizationAttribute,
        domainCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(domainBasePathString)/Project.swift",
              templatePath: "./stencils/domain.stencil"),
        
        // Base Source Files
        .file(path: "\(domainBasePathString)/Interface/Sources/\(domainCapitalizedName)UseCaseInterface.swift",
              templatePath: "./stencils/UseCaseInterface.swift.stencil"),
        .file(path: "\(domainBasePathString)/Implementation/Sources/\(domainCapitalizedName)UseCase.swift",
              templatePath: "./stencils/UseCase.swift.stencil"),
        .file(path: "\(domainBasePathString)/Testing/Sources/Testing\(domainCapitalizedName)UseCase.swift",
              templatePath: "./stencils/TestingRepository.swift.stencil"),
        .file(path: "\(domainBasePathString)/Tests/Sources/\(domainCapitalizedName)UseCaseTests.swift",
              templatePath: "./stencils/UseCaseTests.swift.stencil"),
    ]
)
