// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Espresso",
    platforms: [.iOS(.v13)],
    products: [

        .library(
            name: "Core",
            targets: ["Espresso"]
        ),

        .library(
            name: "UI",
            targets: ["EspressoUI"]
        ),

        .library(
            name: "Promise", 
            targets: ["EspressoPromise"]
        ),

        // MARK: Library Support

        .library(
            name: "LibSupport_Spider", 
            targets: ["EspressoLibSupport_Spider"]
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
            name: "Espresso",
            dependencies: [

                .product(
                    name: "CombineExt", 
                    package: "CombineExt"
                )

            ],
            path: "Sources/Core"
        ),

        .target(
            name: "EspressoUI",
            dependencies: [

                .target(name: "Espresso"), // Core

                .product(
                    name: "Kingfisher", 
                    package: "Kingfisher"
                )

            ],
            path: "Sources/UI"
        ),

        .target(
            name: "EspressoPromise",
            dependencies: [

                .target(name: "Espresso"), // Core

                .product(
                    name: "PromiseKit", 
                    package: "PromiseKit"
                )

            ],
            path: "Sources/Promise"
        ),

        // MARK: Library Support

        .target(
            name: "EspressoLibSupport_Spider",
            dependencies: [],
            path: "Sources/LibSupport/Spider"
        )

    ],
    swiftLanguageVersions: [.v5]
)
