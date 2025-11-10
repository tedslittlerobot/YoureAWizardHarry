// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "YoureAWizardHarry",
    platforms: [
        .iOS(.v26),
        .macOS(.v26),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "YoureAWizardHarry",
            targets: ["YoureAWizardHarry"],
        )
    ],
    dependencies: [
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", from: "2.0.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "YoureAWizardHarry",
            dependencies: [.Confetti],
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["YoureAWizardHarry"],
        ),
    ]
)

extension PackageDescription.Target.Dependency {
    static var Confetti: Self { .product(name: "ConfettiSwiftUI", package: "ConfettiSwiftUI") }
}
