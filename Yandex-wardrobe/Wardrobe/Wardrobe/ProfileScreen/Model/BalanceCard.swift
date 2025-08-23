import Foundation

struct BalanceCard: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let amount: String
    let label: String
    let hasTooltip: Bool
    let hasChevron: Bool
}

extension BalanceCard {
    
    static let splitCard = BalanceCard(
        icon: .ySplit,
        amount: Spec.splitBalanceAmount,
        label: Spec.splitBalanceText,
        hasTooltip: true,
        hasChevron: false
    )
    
    static let yPayCard = BalanceCard(
        icon: .yPay,
        amount: Spec.cardAmount,
        label: Spec.cardText,
        hasTooltip: false,
        hasChevron: true
    )
}

private enum Spec {
    static let splitBalanceText = "Баланс сплита"
    static let splitBalanceAmount = "100 000₽"
    static let cardText = "Карта"
    static let cardAmount = "0₽"
}
