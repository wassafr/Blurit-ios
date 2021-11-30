// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Blurit",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "Blurit",
      targets: ["Blurit_SDK"])
  ],
  targets: [
          .binaryTarget(
            name: "Blurit_SDK",
            path: "Blurit_SDK.xcframework"
          )
      ]
)
