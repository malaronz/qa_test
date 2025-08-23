import SwiftUICore

private struct LoadingCoordinatorKey: EnvironmentKey {
    static let defaultValue: LoadingCoordinator = LoadingCoordinator()
}

extension EnvironmentValues {
    var loadingCoordinator: LoadingCoordinator {
        get { self[LoadingCoordinatorKey.self] }
        set { self[LoadingCoordinatorKey.self] = newValue }
    }
}
