import SwiftUI

extension View {
    /// Добавляет попап к view с координатором
    func popupSheet(coordinator: PopupCoordinator) -> some View {
        ZStack {
            self
            PopupView(viewModel: PopupViewModel(coordinator: coordinator))
            .ignoresSafeArea(edges: .all)
        }
        .environment(\.popupCoordinator, coordinator)
    }
    
    /// Показывает попап с контентом и конфигурацией
    func showPopup<Content: View>(_ content: Content, config: PopupConfiguration = .default) {
        let coordinator = PopupCoordinator()
        coordinator.show(content, config: config)
    }
    
    /// Скрывает попап через координатор из Environment
    func hidePopup() {
        let coordinator = PopupCoordinator()
        coordinator.hide()
    }
}
