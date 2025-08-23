import SwiftUI

/// Environment key для координатора TabBar
private struct TabBarCoordinatorKey: EnvironmentKey {
    static let defaultValue: TabBarCoordinator = TabBarCoordinator()
}

extension EnvironmentValues {
    var tabBarCoordinator: TabBarCoordinator {
        get { self[TabBarCoordinatorKey.self] }
        set { self[TabBarCoordinatorKey.self] = newValue }
    }
}
