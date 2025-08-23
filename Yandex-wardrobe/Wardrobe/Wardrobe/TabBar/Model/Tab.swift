import DeveloperToolsSupport

enum Tab: CaseIterable, Hashable {
    case home
    case aliceGPT
    case lavka
    case favorites
    case cart
    case profile
    
    var icon: ImageResource {
        switch self {
        case .home:
            return .home
        case .aliceGPT:
            return .aliceGPT
        case .lavka:
            return .yLavka
        case .favorites:
            return .favorite
        case .cart:
            return .cart
        case .profile:
            return .profile
        }
    }
}
