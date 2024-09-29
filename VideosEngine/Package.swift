// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

// Disable before commit, see https://forums.swift.org/t/concurrency-checking-in-swift-packages-unsafeflags/61135
let enforceSwiftConcurrencyChecks = false

let swiftConcurrencySettings: [SwiftSetting] = [
    .unsafeFlags([
        "-Xfrontend", "-strict-concurrency=complete",
    ]),
]
let settings = enforceSwiftConcurrencyChecks ? swiftConcurrencySettings : []

let targets = [
    coreTargets(),
    analyticsTargets(),
    networkTargets(),
]
    .flatMap { $0 }
    .flatMap { $0 }

let package = Package(
    name: "VideosEngine",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .watchOS(.v10)],
    products: libraries(from: targets),
    dependencies: [
        // Anything Swift Package Manager for use
        /// if you want using firebase or mixpanel and anything please input Swift Package Manager to below :
        //Example:
        //.package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.1.0")),
        //.package(url: "https://github.com/mixpanel/mixpanel-swift.git", .upToNextMajor(from: "4.3.0")),
    ],
    targets: validated(targets) + [testTargetLinkingAllPackageTargets(targets)]
)

private func coreTargets() -> [[Target]] {
    let type = TargetType.core
    return [
        target(type, name: "DesignSystemKit", hasTests: false, dependencies: [
            // if use firebase remote config, Databases or anything, make like below:
            // .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
            // .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
            // .product(name: "FirebaseDynamicLinks", package: "firebase-ios-sdk")
        ], resources: [.process("Assets")], path: "DesignSystemKit/Sources"),
    ]
}

private func analyticsTargets() -> [[Target]] {
    let type = TargetType.analytics
    return [
        target(type, name: "AnalyticsKit", hasTests: false, dependencies: [
            // if use analytics or anything, make like below:
            //.product(name: "Mixpanel", package: "mixpanel-swift"),
            //.product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
            //.product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk"),
            //.product(name: "FirebasePerformance", package: "firebase-ios-sdk"),
        ], path: "AnalyticsKit/Sources"),
    ]
}

private func networkTargets() -> [[Target]] {
    let type = TargetType.networking
    return [
        target(type, name: "NetworkingKit", hasTests: false, dependencies: [
        ], path: "NetworkingKit/Sources"),
    ]
}

// MARK: - Builders

enum TargetType: String {
    case core = "DesignSystemKit"
    case networking = "NetworkingKit"
    case analytics = "AnalyticsKit"
    
    // MARK: Internal
    
    static let validDependencies: [TargetType: Set<TargetType>] = [
        .core: [.core],
        .networking: [.core, .analytics],
        .analytics: [.core, .networking],
    ]
}

func target(
    _ type: TargetType,
    name: String,
    hasTests: Bool = true,
    dependencies: [Target.Dependency] = [],
    resources: [Resource]? = nil,
    exclude: [String] = [],
    path: String,
    testDependencies: [Target.Dependency] = [],
    testExclude: [String] = [],
    testResources: [Resource]? = nil
) -> [Target] {
    var targets: [Target] = [
        .target(
            name: name,
            dependencies: dependencies,
            path: path,
            exclude: exclude,
            resources: resources,
            swiftSettings: settings
        ),
    ]
    guard hasTests else {
        return targets
    }
    targets.append(
        .testTarget(
            name: name + "Tests",
            dependencies: [.init(stringLiteral: name)] + testDependencies,
            path: path + "/Tests",
            exclude: testExclude,
            resources: testResources,
            swiftSettings: settings
        )
    )
    return targets
}

func library(_ name: String) -> PackageDescription.Product {
    .library(name: name, targets: [name])
}

func validated(_ targets: [Target]) -> [Target] {
    validateDependenciesStructure(targets)
    validateNoTestDependenciesInAppTargets(targets)
    return targets
}

func validateNoTestDependenciesInAppTargets(_ targets: [Target]) {
    func isTestRelatedTargetName(_ name: String) -> Bool {
        ["tests", "test"].contains { testName in name.lowercased().contains(testName) }
    }
    
    let targets = targets.filter { target in !target.isTest && !isTestRelatedTargetName(target.name) }
    for target in targets {
        for dependency in target.dependencies {
            let dependencyName = dependencyName(of: dependency)
            if isTestRelatedTargetName(dependencyName) {
                fatalError("""
                
                Incorrect dependency.
                Target \(target.name) shouldn't depend on \(dependencyName) as it's a test dependency.
                
                """)
            }
        }
    }
}

func validateDependenciesStructure(_ targets: [Target]) {
    var targetTypes: [String: TargetType] = [:]
    for target in targets {
        let parentDirectory = target.path!.components(separatedBy: "/")[0]
        targetTypes[target.name] = TargetType(rawValue: parentDirectory)!
    }
    
    for target in targets {
        let targetType = targetTypes[target.name]!
        let validDependencyTypes = TargetType.validDependencies[targetType]!
        for dependency in target.dependencies {
            let dependencyName = dependencyName(of: dependency)
            guard let dependencyType = targetTypes[dependencyName] else {
                continue
            }
            if !validDependencyTypes.contains(dependencyType) {
                fatalError("""
                
                Incorrect dependency.
                Target \(targetType.rawValue)\\\(target.name) shouldn't depend on \(dependencyType.rawValue)\\\(dependencyName).
                
                """)
            }
        }
    }
}

func dependencyName(of dependency: Target.Dependency) -> String {
    if case .byNameItem(name: let name, condition: _) = dependency {
        return name
    }
    return ""
}

/// Creates an empty test target that links all targets to produce an accurate code coverage.
func testTargetLinkingAllPackageTargets(_ targets: [Target]) -> Target {
    let nonTestTargets = targets.filter { !$0.isTest }
    return .testTarget(
        name: "AllTargetsTests",
        dependencies: nonTestTargets.map { .init(stringLiteral: $0.name) },
        path: "AllTargetsTests",
        swiftSettings: settings
    )
}

func libraries(from targets: [Target]) -> [PackageDescription.Product] {
    let nonTestTargets = targets.filter { !$0.isTest }
    return nonTestTargets.map {
        library($0.name)
    }
}
