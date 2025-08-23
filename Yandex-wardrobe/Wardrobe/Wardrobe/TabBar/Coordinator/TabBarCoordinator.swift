import SwiftUI

/// Протокол для координации TabBar
protocol TabBarCoordinating: ObservableObject {
    var isVisible: Bool { get }
    func hide()
    func show()
}

final class TabBarCoordinator: TabBarCoordinating {
    @Published var isVisible: Bool = true
    
    func hide() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isVisible = false
        }
    }
    
    func show() {
        withAnimation(.easeInOut(duration: 0.2)) {
            isVisible = true
        }
    }
}
