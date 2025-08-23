import Foundation

struct MenuSection: Identifiable {
    let id = UUID()
    let title: String
    let items: [MenuItem]
}

extension MenuSection {
    
    static let purchasesSection = MenuSection(
        title: Spec.purchasesSectionTitle,
        items: MenuItem.purchaseItems
    )
    
    static let benefitsSection = MenuSection(
        title: Spec.benefitsSectionTitle,
        items: MenuItem.benefitItems
    )
    
    static let myMarketSection = MenuSection(
        title: Spec.myMarketSectionTitle,
        items: MenuItem.myMarketItems
    )
}

private enum Spec {
    static let purchasesSectionTitle = "Покупки"
    static let benefitsSectionTitle = "Выгода"
    static let myMarketSectionTitle = "Мой Маркет"
}
