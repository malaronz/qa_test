import SwiftUICore

/// Environment key для координатора попапа
private struct PopupCoordinatorKey: EnvironmentKey {
    static let defaultValue: PopupCoordinator = PopupCoordinator()
}

extension EnvironmentValues {
    var popupCoordinator: PopupCoordinator {
        get { self[PopupCoordinatorKey.self] }
        set { self[PopupCoordinatorKey.self] = newValue }
    }
}
