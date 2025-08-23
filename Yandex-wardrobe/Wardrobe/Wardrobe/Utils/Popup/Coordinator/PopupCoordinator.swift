import Combine
import SwiftUICore

/// Протокол для реактивных потоков состояния попапа
protocol PopupStateStream {
    var statePublisher: AnyPublisher<PopupState, Never> { get }
    var configPublisher: AnyPublisher<PopupConfiguration, Never> { get }
    var offsetPublisher: AnyPublisher<CGFloat, Never> { get }
    var contentPublisher: AnyPublisher<AnyView?, Never> { get }
    var hasActivePopup: AnyPublisher<Bool, Never> { get }
    var detentCommandPublisher: AnyPublisher<PopupDetentCommand, Never> { get }
}

/// Протокол для координации попапа
protocol PopupCoordinating: PopupStateStream, ObservableObject {
    func show<Content: View>(_ content: Content, config: PopupConfiguration)
    func hide()
    func handleDragChange(_ offset: CGFloat)
    func handleDragEnd(translation: CGFloat, velocity: CGFloat)
    func advanceDetent()
    func setDetent(_ detent: PopupDetent)
}

final class PopupCoordinator: PopupCoordinating, ObservableObject {
    private let stateSubject = CurrentValueSubject<PopupState, Never>(.hidden)
    private let configSubject = CurrentValueSubject<PopupConfiguration, Never>(.default)
    private let offsetSubject = CurrentValueSubject<CGFloat, Never>(0)
    private let contentSubject = CurrentValueSubject<AnyView?, Never>(nil)
    private let detentCommandSubject = PassthroughSubject<PopupDetentCommand, Never>()
    
    var statePublisher: AnyPublisher<PopupState, Never> { 
        stateSubject.eraseToAnyPublisher() 
    }
    
    var configPublisher: AnyPublisher<PopupConfiguration, Never> {
        configSubject.eraseToAnyPublisher()
    }
    
    var offsetPublisher: AnyPublisher<CGFloat, Never> { 
        offsetSubject.eraseToAnyPublisher() 
    }
    
    var contentPublisher: AnyPublisher<AnyView?, Never> {
        contentSubject.eraseToAnyPublisher()
    }
    
    var hasActivePopup: AnyPublisher<Bool, Never> {
        statePublisher.map { $0 == .visible || $0 == .appearing || $0 == .dismissing }.eraseToAnyPublisher()
    }
    
    var detentCommandPublisher: AnyPublisher<PopupDetentCommand, Never> {
        detentCommandSubject.eraseToAnyPublisher()
    }
    
    func show<Content: View>(_ content: Content, config: PopupConfiguration = .default) {
        configSubject.send(config)
        contentSubject.send(AnyView(content))
        stateSubject.send(.appearing)
        
        withAnimation(config.animationConfig) {
            stateSubject.send(.visible)
        }
    }
    
    func hide() {
        withAnimation(configSubject.value.animationConfig) {
            stateSubject.send(.dismissing)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.stateSubject.send(.hidden)
            self.contentSubject.send(nil)
            self.offsetSubject.send(0)
        }
    }
    
    func handleDragChange(_ offset: CGFloat) {
        guard stateSubject.value == .visible else { return }
        offsetSubject.send(max(0, offset))
    }
    
    func handleDragEnd(translation: CGFloat, velocity: CGFloat) {
        guard stateSubject.value == .visible else { return }
        
        let shouldDismiss = translation > configSubject.value.dismissThreshold ||
                           velocity > configSubject.value.velocityThreshold
        
        if shouldDismiss {
            hide()
        } else {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                offsetSubject.send(0)
            }
        }
    }
    
    func advanceDetent() {
        detentCommandSubject.send(.next)
    }
    
    func setDetent(_ detent: PopupDetent) {
        detentCommandSubject.send(.set(detent))
    }
}
