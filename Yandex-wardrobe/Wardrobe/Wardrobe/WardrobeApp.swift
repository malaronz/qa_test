import SwiftUI

@main
struct WardrobeApp: App {
    @StateObject private var popupCoordinator = PopupCoordinator()
    @StateObject private var loadingCoordinator = LoadingCoordinator()
    @StateObject private var tabBarCoordinator = TabBarCoordinator()

    init() {
        AnalyticsService.initialize()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .popupSheet(coordinator: popupCoordinator)
                .loadingOverlay(coordinator: loadingCoordinator)
                .tabBarCoordinator(tabBarCoordinator)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    AnalyticsService.startSession()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    AnalyticsService.pauseSession()
                }
        }
    }
}
