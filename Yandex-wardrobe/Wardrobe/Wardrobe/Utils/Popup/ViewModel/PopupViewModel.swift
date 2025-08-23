import SwiftUICore
import UIKit
import Combine

final class PopupViewModel: ObservableObject {
    private let coordinator: any PopupCoordinating
    private var cancellables = Set<AnyCancellable>()
    
    @Published var state: PopupState = .hidden
    @Published var config: PopupConfiguration = .default
    @Published var dragOffset: CGFloat = 0
    @Published var content: AnyView?
    @Published var isVisible = false
    @Published var currentDetent: PopupDetent?
    @Published var contentHeight: CGFloat = 0
    
    init(coordinator: any PopupCoordinating) {
        self.coordinator = coordinator
        setupBindings()
    }
    
    private func setupBindings() {
        coordinator.statePublisher
            .assign(to: \.state, on: self)
            .store(in: &cancellables)
        
        coordinator.configPublisher
            .assign(to: \.config, on: self)
            .store(in: &cancellables)
        
        coordinator.configPublisher
            .sink { [weak self] cfg in
                guard let self else { return }
                if !cfg.detents.isEmpty {
                    self.currentDetent = cfg.initialDetent ?? cfg.detents.first
                } else {
                    self.currentDetent = nil
                }
            }
            .store(in: &cancellables)
        
        coordinator.offsetPublisher
            .assign(to: \.dragOffset, on: self)
            .store(in: &cancellables)
        
        coordinator.hasActivePopup
            .assign(to: \.isVisible, on: self)
            .store(in: &cancellables)
        
        coordinator.contentPublisher
            .assign(to: \.content, on: self)
            .store(in: &cancellables)
        
        coordinator.detentCommandPublisher
            .sink { [weak self] command in
                guard let self else { return }
                switch command {
                case .next:
                    self.advanceDetent()
                case .set(let d):
                    self.currentDetent = d
                }
            }
            .store(in: &cancellables)
    }
    
    func show<Content: View>(_ content: Content, config: PopupConfiguration) {
        coordinator.show(content, config: config)
    }
    
    func hide() {
        coordinator.hide()
    }
    
    func handleDragChange(_ offset: CGFloat) {
        coordinator.handleDragChange(offset)
    }
    
    func handleDragEnd(translation: CGFloat, velocity: CGFloat) {
        coordinator.handleDragEnd(translation: translation, velocity: velocity)
    }
}

private extension PopupViewModel {
    func advanceDetent() {
        guard let detents = config.detents.nonEmpty, let current = currentDetent else { return }
        let containerHeight: CGFloat = UIScreen.main.bounds.height
        let sorted = detents.sorted { a, b in
            a.resolvedHeight(containerHeight: containerHeight) < b.resolvedHeight(containerHeight: containerHeight)
        }
        let currentHeight = current.resolvedHeight(containerHeight: containerHeight)
        if let next = sorted.first(where: { $0.resolvedHeight(containerHeight: containerHeight) > currentHeight }) {
            withAnimation(config.animationConfig) {
                currentDetent = next
            }
        }
    }
}

private extension Array {
    var nonEmpty: [Element]? { isEmpty ? nil : self }
}
