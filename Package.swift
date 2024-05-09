// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Espresso",
    platforms: [.iOS(.v15)],
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
        )

    ],
    dependencies: [
        
        .package(
            url: "https://github.com/CombineCommunity/CombineExt",
            .upToNextMajor(from: .init(1, 8, 0))
        ),

        .package(
            url: "https://github.com/SnapKit/SnapKit",
            .upToNextMajor(from: .init(5, 6, 0))
        ),

        .package(
            url: "https://github.com/mxcl/PromiseKit",
            .upToNextMajor(from: .init(6, 0, 0))
        ),
        
        .package(
            url: "https://github.com/mitchtreece/Lumberjack",
            .upToNextMajor(from: .init(1, 0, 0))
        ),
        
        .package(
            url: "https://github.com/kean/Pulse",
            .upToNextMajor(from: .init(4, 0, 0))
        ),
        
        .package(
            url: "https://github.com/SFSafeSymbols/SFSafeSymbols",
            .upToNextMajor(from: .init(5, 0, 0))
        )

    ],
    targets: [

        .target(
            name: "Espresso",
            dependencies: [
                
                .product(
                    name: "CombineExt", 
                    package: "CombineExt"
                ),
                
                .product(
                    name: "Lumberjack",
                    package: "Lumberjack"
                ),
                
                .product(
                    name: "Pulse",
                    package: "Pulse"
                )

            ],
            path: "Sources/Core"
        ),

        .target(
            name: "EspressoUI",
            dependencies: [

                .target(name: "Espresso"),

                .product(
                    name: "SnapKit", 
                    package: "SnapKit"
                ),

                .product(
                    name: "SFSafeSymbols",
                    package: "SFSafeSymbols"
                )

            ],
            path: "Sources/UI"
        ),

        .target(
            name: "EspressoPromise",
            dependencies: [

                .target(name: "Espresso"),

                .product(
                    name: "PromiseKit", 
                    package: "PromiseKit"
                )

            ],
            path: "Sources/Promise"
        )

    ],
    swiftLanguageVersions: [.v5]
)
