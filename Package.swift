// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Espresso",
    platforms: [.iOS(.v13)],
    swiftLanguageVersions: [.v5],
    dependencies: [],
    products: [

        .library(
            name: "Espresso",
            targets: ["Core"]
        ),

        .library(
            name: "EspressoUI",
            targets: [
                "UICore",
                "UIKit",
                "SwiftUI"
            ]
        ),

        .library(
            name: "EspressoPromise", 
            targets: ["Promise"]
        ),

        // MARK: Library Support

        .library(
            name: "EspressoLibrarySupport_Spider", 
            targets: ["LibSupport_Spider"]
        )

    ],
    targets: [

        .target(
            name: "Core",
            path: "Sources/Core",
            dependencies: [

                .package(
                    name: "CombineExt",
                    url: "https://github.com/CombineCommunity/CombineExt",
                    .upToNextMajor(from: .init(1, 8, 0))
                )

            ]
        ),

        .target(
            name: "UICore",
            path: "Sources/UI/Core",
            dependencies: [
                .target(name: "Core")
            ]
        ),

        .target(
            name: "UIKit",
            path: "Sources/UI/UIKit",
            dependencies: [

                .target(name: "UICore"),
                
                .package(
                    name: "Kingfisher",
                    url: "https://github.com/onevcat/Kingfisher",
                    .upToNextMajor(from: .init(7, 0, 0))
                )

            ]
        ),

        .target(
            name: "SwiftUI",
            path: "Sources/UI/SwiftUI",
            dependencies: [
                .target(name: "UIKit")
            ]
        ),

        .target(
            name: "Promise",
            path: "Sources/Promise",
            dependencies: [

                .target(name: "Core"),

                .package(
                    name: "PromiseKit",
                    url: "https://github.com/mxcl/PromiseKit",
                    .upToNextMajor(from: .init(6, 0, 0))
                )

            ]
        ),

        // MARK: Library Support

        .target(
            name: "LibSupport_Spider",
            path: "Sources/Core",
            sources: [
                "Types/JSON/JSON.swift",
                "Types/JSON/JSONError.swift",
                "Types/JSON/JSONRepresentable.swift",
                "Types/URLRepresentable.swift",
                "Extensions/NSObject+Espresso.swift"
            ],
            dependencies: []
        )

    ]
)
