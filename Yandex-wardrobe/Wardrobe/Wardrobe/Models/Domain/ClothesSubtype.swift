enum ClothesSubtype: String, CaseIterable, Identifiable {
    var id: String { rawValue }

    // Верх
    case sneakers = "кеды"
    case blouse = "блуза"
    case hoodie = "худи"
    case shirt = "рубашка"
    case longsleeve = "лонгслив"
    case tShirt = "футболка"
    case sweatshirt = "свитшот"
    case top = "топ"

    // Низ
    case skirt = "юбка"
    case trousers = "брюки"
    case breeches = "бриджи"
    case capri = "капри"
    case shorts = "шорты"
    case jeans = "джинсы"

    // Обувь
    case shoes = "туфли"
    case loafers = "лоферы"
    case sabo = "сабо"
    case slippers = "шлепанцы"
    case sneakersSport = "кроссовки"
    case aquaShoes = "акваобувь"

    case none = ""

    var type: ClothesType {
        switch self {
        case .blouse, .hoodie, .shirt, .longsleeve, .tShirt, .sweatshirt, .top:
            return .top
        case .skirt, .trousers, .breeches, .capri, .shorts, .jeans:
            return .bottom
        case .shoes, .loafers, .sabo, .slippers, .sneakersSport, .aquaShoes, .sneakers:
            return .shoes
        case .none:
            return .none
        }
    }

    var title: String {
        rawValue.capitalized
    }
}
