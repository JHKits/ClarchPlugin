//
//  repositoryInterface.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let repositoryInterfaceNameAttribute: Template.Attribute = .optional("name", default: "")
let repositoryInterfaceRepositoryNameAttribute: Template.Attribute = .required("repositoryName")


//MARK: - Attributes for header
let repositoryInterfaceAuthorAttribute: Template.Attribute = .optional("author",
                                                               default: "nil")
let repositoryInterfaceCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                    default: "nil")
let repositoryInterfaceOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                     default: "nil")
let repositoryInterfaceCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                      default: "nil")


// MARK: - Utils
let repositoryInterfaceCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let repositoryInterfaceRepositoryCapitalizedName = "{{ repositoryName[0] | uppercase }}{% for i in 1...repositoryName.count %}{{ repositoryName[i] }}{% endfor %}"
let repositoryInterfaceBasePathString = "Domain/\(repositoryInterfaceCapitalizedName)RepositoryInterfaces/\(repositoryInterfaceRepositoryCapitalizedName)RepositoryInterface"


//MARK: - Template
let repositoryInterfaceTemplate = Template(
    description: "RepositoryInterface Template",
    attributes: [
        repositoryInterfaceNameAttribute,
        repositoryInterfaceRepositoryNameAttribute,
        repositoryInterfaceAuthorAttribute,
        repositoryInterfaceCurrentDateAttribute,
        repositoryInterfaceOrganizationAttribute,
        repositoryInterfaceCopyrightYearAttribute,
    ],
    items: [
        // Base Source Files
        .file(path: "\(repositoryInterfaceBasePathString)/Sources/\(repositoryInterfaceRepositoryCapitalizedName)RepositoryInterface.swift",
              templatePath: "./stencils/RepositoryInterface.swift.stencil")
    ]
)
