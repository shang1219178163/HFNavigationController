// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "HFNavigationController",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "HFNavigationController",
            targets: ["HFNavigationController"]
        )
    ],
    targets: [
        .target(
            name: "HFNavigationController",
            path: "HFNavigationController/Classes",
            exclude: [".gitkeep"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
