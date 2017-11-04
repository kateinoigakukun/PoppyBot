// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PoppyBot",
    dependencies: [
        .package(url: "https://github.com/SlackKit/SlackKit.git", from: Version(4,0,0)),
        .package(url: "https://github.com/Ponyboy47/Cron-Swift.git", from: Version(1,0,0)),
        .package(url: "https://github.com/vadymmarkov/Rexy.git", Version(0,1,0)..<Version(1,0,0)),
        .package(url: "https://github.com/tid-kijyun/Kanna.git", .branch("feature/v4.0.0")),
        .package(url: "https://github.com/vapor/sqlite-driver.git", from: Version(1,1,0)),
        .package(url: "https://github.com/nmdias/FeedKit.git", from: Version(7,0,1))
    ],
    targets: [
        .target(name: "PoppyBot", dependencies: [
            "SlackKit",
            "Cron",
            "Rexy",
            "Kanna",
            "FeedKit",
            "Model",
            "Extension",
            "Logger"
            ]),
        .target(name: "Model", dependencies: [
            "FluentSQLite",
            "Extension",
            "Logger"
        ]),
        .target(name: "Logger", dependencies: ["SlackKit"]),
        .target(name: "Extension"),
    ]
)
