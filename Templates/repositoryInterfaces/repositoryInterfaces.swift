//
//  repositoryInterfaces.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let repositoryInterfacesNameAttribute: Template.Attribute = .optional("name", default: "")
let repositoryInterfacesRepositoryNamesAttribute: Template.Attribute = .optional("repositoryNames", default: "")


//MARK: - Attributes for header
let repositoryInterfacesAuthorAttribute: Template.Attribute = .optional("author",
                                                               default: "nil")
let repositoryInterfacesCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                    default: "nil")
let repositoryInterfacesOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                     default: "nil")
let repositoryInterfacesCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                      default: "nil")


// MARK: - Utils
let repositoryInterfacesCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let repositoryInterfacesBasePathString = "Domain/\(repositoryInterfacesCapitalizedName)RepositoryInterfaces"


//MARK: - Template
let repositoryInterfacesTemplate = Template(
    description: "RepositoryInterfaces Template",
    attributes: [
        repositoryInterfacesNameAttribute,
        repositoryInterfacesRepositoryNamesAttribute,
        repositoryInterfacesAuthorAttribute,
        repositoryInterfacesCurrentDateAttribute,
        repositoryInterfacesOrganizationAttribute,
        repositoryInterfacesCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(repositoryInterfacesBasePathString)/Project.swift",
              templatePath: "./stencils/repositoryInterfaces.stencil"),
    ]
)
