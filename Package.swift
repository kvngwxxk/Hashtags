// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Hashtags",
    platforms: [
        .iOS(.v15) // 최소 지원 버전
    ],
    products: [
        .library(
            name: "Hashtags",
            targets: ["Hashtags"]
        ),
    ],
    targets: [
        .target(
            name: "Hashtags",
            path: "Hashtags" // 소스 디렉토리 경로
        )
    ]
)
