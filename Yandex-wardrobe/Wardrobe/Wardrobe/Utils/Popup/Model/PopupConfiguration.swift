import SwiftUICore

/// Конфигурация для попапа
struct PopupConfiguration {
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let shadowOpacity: Double
    let backgroundOpacity: Double
    let dismissThreshold: CGFloat
    let velocityThreshold: CGFloat
    let animationConfig: Animation
    let detents: [PopupDetent]
    let initialDetent: PopupDetent?
    
    static let `default` = PopupConfiguration(
        cornerRadius: 20,
        shadowRadius: 24,
        shadowOpacity: 0.12,
        backgroundOpacity: 0.4,
        dismissThreshold: 100,
        velocityThreshold: 500,
        animationConfig: .interpolatingSpring(stiffness: 222, damping: 28),
        detents: [.fraction(0.5)],
        initialDetent: .fraction(0.5)
    )
    
    static let compact = PopupConfiguration(
        cornerRadius: 16,
        shadowRadius: 16,
        shadowOpacity: 0.08,
        backgroundOpacity: 0.3,
        dismissThreshold: 80,
        velocityThreshold: 400,
        animationConfig: .spring(response: 0.4, dampingFraction: 0.8),
        detents: [.fraction(0.3)],
        initialDetent: .fraction(0.3)
    )
    
    static let large = PopupConfiguration(
        cornerRadius: 24,
        shadowRadius: 32,
        shadowOpacity: 0.16,
        backgroundOpacity: 0.5,
        dismissThreshold: 120,
        velocityThreshold: 600,
        animationConfig: .interpolatingSpring(stiffness: 200, damping: 25),
        detents: [.fraction(0.7)],
        initialDetent: .fraction(0.7)
    )
}
