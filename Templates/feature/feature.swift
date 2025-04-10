//
//  feature.swift
//  Plugins
//
//  Created by Jeonhui on 4/8/25.
//

@preconcurrency import ProjectDescription

//MARK: - Attributes
let featureNameAttribute: Template.Attribute = .required("name")


//MARK: - Attributes for header
let featureAuthorAttribute: Template.Attribute = .optional("author",
                                                           default: "nil")
let featureCurrentDateAttribute: Template.Attribute = .optional("currentDate",
                                                                default: "nil")
let featureOrganizationAttribute: Template.Attribute = .optional("organization",
                                                                 default: "nil")
let featureCopyrightYearAttribute: Template.Attribute = .optional("copyrightYear",
                                                                  default: "nil")


// MARK: - Utils
let featureCapitalizedName = "{{ name[0] | uppercase }}{% for i in 1...name.count %}{{ name[i] }}{% endfor %}"
let featureBasePathString = "Feature/\(featureCapitalizedName)Feature"


//MARK: - Template
let featureTemplate = Template(
    description: "Feature Template",
    attributes: [
        featureNameAttribute,
        featureAuthorAttribute,
        featureCurrentDateAttribute,
        featureOrganizationAttribute,
        featureCopyrightYearAttribute,
    ],
    items: [
        // Project
        .file(path: "\(featureBasePathString)/Project.swift",
              templatePath: "./stencils/feature.stencil"),
        
        // Base Source Files
        .file(path: "\(featureBasePathString)/Interface/Sources/\(featureCapitalizedName)CoordinatorInterface.swift",
              templatePath: "./stencils/CoordinatorInterface.swift.stencil"),
        .file(path: "\(featureBasePathString)/Interface/Sources/\(featureCapitalizedName)CoordinatorDestination.swift",
              templatePath: "./stencils/CoordinatorDestination.swift.stencil"),
        .file(path: "\(featureBasePathString)/Implementation/Sources/\(featureCapitalizedName)Coordinator.swift",
                  templatePath: "./stencils/Coordinator.swift.stencil"),
        .file(path: "\(featureBasePathString)/Implementation/Sources/\(featureCapitalizedName)View.swift",
              templatePath: "./stencils/View.swift.stencil"),
        .file(path: "\(featureBasePathString)/Testing/Sources/Testing\(featureCapitalizedName)UseCase.swift",
              templatePath: "./stencils/TestingUseCase.swift.stencil"),
        .file(path: "\(featureBasePathString)/Tests/Sources/\(featureCapitalizedName)FeatureTests.swift",
              templatePath: "./stencils/FeatureTests.swift.stencil"),
        .file(path: "\(featureBasePathString)/Example/Sources/Example\(featureCapitalizedName)View.swift",
                  templatePath: "./stencils/ExampleView.swift.stencil"),
        
        // Base Resource Files
        .string(path: "\(featureBasePathString)/Implementation/Resources/empty.swift",
                contents: "// Resource")
    ]
)
