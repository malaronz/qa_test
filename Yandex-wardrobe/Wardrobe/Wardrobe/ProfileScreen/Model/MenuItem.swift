import Foundation

struct MenuItem: Identifiable {
    let id = UUID()
    let icon: ImageResource
    let title: String
    let subtitle: String?
    let badge: String?
    let trailingIcon: ImageResource?
    
    init(
        icon: ImageResource,
        title: String,
        subtitle: String? = nil,
        badge: String? = nil,
        trailingIcon: ImageResource? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.badge = badge
        self.trailingIcon = trailingIcon
    }
}

extension MenuItem {
    
    static let purchaseItems: [MenuItem] = [
        MenuItem(
            icon: .orders,
            title: Spec.ordersTitle,
            badge: Spec.ordersBadge
        ),
        MenuItem(icon: .bought, title: Spec.boughtItemsTitle),
        MenuItem(icon: .returns, title: Spec.returnsTitle)
    ]
    
    static let benefitItems: [MenuItem] = [
        MenuItem(
            icon: .promocode,
            title: Spec.promocodesTitle,
            badge: Spec.promocodesBadge
        ),
        MenuItem(
            icon: .prizeWheel,
            title: Spec.prizeWheelTitle,
            subtitle: Spec.prizeWheelSubtitle,
            trailingIcon: .coin
        ),
        MenuItem(
            icon: .cashback,
            title: Spec.favoriteCategoryTitle,
            subtitle: Spec.favoriteCategorySubtitle
        )
    ]
    
    static let myMarketItems = [
        MenuItem(
            icon: .reviews,
            title: Spec.reviewsTitle,
            subtitle: Spec.reviewsSubtitle,
            badge: Spec.reviewsBadge
        ),
        MenuItem(icon: .wardrobe, title: Spec.wardrobeTitle),
        MenuItem(icon: .liked, title: Spec.favoritesTitle),
        MenuItem(icon: .compare, title: Spec.compareListsTitle)
    ]
}

private enum Spec {

    // Menu Item Titles
    static let ordersTitle = "Заказы"
    static let boughtItemsTitle = "Купленные товары"
    static let returnsTitle = "Возвраты"
    static let promocodesTitle = "Промокоды"
    static let prizeWheelTitle = "Колесо призов"
    static let favoriteCategoryTitle = "Любимая категория"
    static let reviewsTitle = "Отзывы и вопросы"
    static let wardrobeTitle = "Мой гардероб"
    static let favoritesTitle = "Избранное"
    static let compareListsTitle = "Списки сравнения"
    
    // Menu Item Subtitles
    static let prizeWheelSubtitle = "Приз с каждого вращения"
    static let favoriteCategorySubtitle = "В июне скидки до 40%"
    static let reviewsSubtitle = "от 50 баллов за отзыв"
    
    // Badges
    static let ordersBadge = "9+"
    static let promocodesBadge = "1"
    static let reviewsBadge = "9+"
}
