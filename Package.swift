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
    dependencies: [
        .package(url: "https://github.com/kvngwxxk/AlignedCollectionViewFlowLayout.git", from: "1.1.2") // 버전은 필요에 따라 조정
    ],
    targets: [
        .target(
            name: "Hashtags",
            dependencies: [
                .product(name: "AlignedCollectionViewFlowLayout", package: "AlignedCollectionViewFlowLayout")
            ],
            path: "Hashtags" // 소스 디렉토리 경로
        )
    ]
)
