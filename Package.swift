// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Espresso",
    platforms: [.iOS(.v13)],
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
            name: "EspressoLibSupport_Spider", 
            targets: ["LibSupport_Spider"]
        )

    ],
    dependencies: [

        .package(
            name: "CombineExt",
            url: "https://github.com/CombineCommunity/CombineExt",
            .upToNextMajor(from: .init(1, 8, 0))
        ),

        .package(
            name: "Kingfisher",
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: .init(7, 0, 0))
        ),

        .package(
            name: "PromiseKit",
            url: "https://github.com/mxcl/PromiseKit",
            .upToNextMajor(from: .init(6, 0, 0))
        )

    ],
    targets: [

        .target(
            name: "Core",
            dependencies: [

                .product(
                    name: "CombineExt", 
                    package: "CombineExt"
                )

            ],
            path: "Sources/Core"
        ),

        .target(
            name: "UICore",
            dependencies: [
                .target(name: "Core")
            ],
            path: "Sources/UI/Core"
        ),

        .target(
            name: "UIKit",
            dependencies: [

                .target(name: "UICore"),

                .product(
                    name: "Kingfisher", 
                    package: "Kingfisher"
                )

            ],
            path: "Sources/UI/UIKit"
        ),

        .target(
            name: "SwiftUI",
            dependencies: [
                .target(name: "UIKit")
            ],
            path: "Sources/UI/SwiftUI"
        ),

        .target(
            name: "Promise",
            dependencies: [

                .target(name: "Core"),

                .product(
                    name: "PromiseKit", 
                    package: "PromiseKit"
                )

            ],
            path: "Sources/Promise"
        ),

        // MARK: Library Support

        .target(
            name: "LibSupport_Spider",
            dependencies: [],
            path: "Sources/LibSupport/Spider"
        )

    ],
    swiftLanguageVersions: [.v5]
)
