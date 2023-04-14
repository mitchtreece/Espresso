// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Espresso",
    platforms: [.iOS(.v13)],
    products: [

        .library(
            name: "Espresso",
            targets: ["Espresso"]
        ),

        .library(
            name: "EspressoUI",
            targets: ["EspressoUI"]
        ),

        .library(
            name: "EspressoPromise", 
            targets: ["EspressoPromise"]
        ),

        // MARK: Library Support

        .library(
            name: "EspressoLibSupport_Spider", 
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
            name: "SnapKit",
            url: "https://github.com/SnapKit/SnapKit",
            .upToNextMajor(from: .init(5, 6, 0))
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
                    name: "SnapKit", 
                    package: "SnapKit"
                ),

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
