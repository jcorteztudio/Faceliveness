// swift-tools-version: 5.9
// FaceLivenessFramework

import PackageDescription

let package = Package(
    name: "FaceLivenessFramework",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "FaceLivenessFramework",
            targets: ["FaceLivenessFramework"])
    ],
    targets: [
        .binaryTarget(name: "ISOMDLLib", 
                      url: "https://storage.googleapis.com/cosmo-ios-repo/FaceLivenessFramework.xcframework.zip", 
                      checksum: "7d569c6fe5f771eed1ae6a33ff6db6cbc388ab3dde70d6c8679aceb7f8c349e5")
        ],
    swiftLanguageVersions: [.v5]
)
