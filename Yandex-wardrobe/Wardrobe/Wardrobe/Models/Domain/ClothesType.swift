enum ClothesType: String, CaseIterable {
    case top = "верх"
    case bottom = "низ"
    case shoes = "обувь"
    case none = ""

    var availableSubtypes: [ClothesSubtype] {
           ClothesSubtype.allCases.filter { $0.type == self && $0 != .none }
       }

    var title: String {
        switch self {
        case .top:
            return "Верх"
        case .bottom:
            return "Низ"
        case .shoes:
            return "Обувь"
        case .none:
            return ""
        }
    }
}
