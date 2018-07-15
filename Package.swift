// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "VaporFollowUps-MySQL",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/vapor/mysql-provider.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor","FluentMySQL", "MySQLProvider"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

