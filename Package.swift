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
        .package(url: "https://github.com/kvngwxxk/AlignedCollectionViewFlowLayout.git", from: "1.0.0")

    ],
    targets: [
        .target(
            name: "Hashtags",
            dependencies: [
                .product(name: "AlignedCollectionViewFlowLayout", package: "AlignedCollectionViewFlowLayout")
            ],
            path: "Hashtags",
            // 소스 파일들이 있는 폴더를 명시합니다.
            sources: ["Classes"],
            // 리소스(Assets 폴더)를 포함시킵니다.
            resources: [
                .process("Assets")
            ]
        )
    ]
)
