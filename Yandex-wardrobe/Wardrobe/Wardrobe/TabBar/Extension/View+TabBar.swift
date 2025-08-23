import SwiftUI

extension View {
    func tabBarCoordinator(_ coordinator: TabBarCoordinator) -> some View {
        self.environment(\.tabBarCoordinator, coordinator)
    }
}
