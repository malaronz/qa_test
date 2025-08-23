import SwiftUI

extension View {
    func loadingOverlay(coordinator: LoadingCoordinator) -> some View {
        ZStack {
            self
            if coordinator.isLoading {
                LoadingOverlay(configuration: coordinator.configuration)
            }
        }
        .environment(\.loadingCoordinator, coordinator)
    }
}
