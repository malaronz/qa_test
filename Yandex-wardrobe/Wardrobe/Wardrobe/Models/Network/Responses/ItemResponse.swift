import Foundation

enum StateResponse: String, Decodable {
    case liked
    case bought
    case bucket
    case chosen
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        self = StateResponse(rawValue: raw) ?? .unknown
    }
}

struct ItemResponse: Decodable {
    let id: Int
    let name: String
    let brand: String
    let price: Double
    let rating: Double?
    let description: String
    let type: String
    let subtype: String?
    let variants: [OptionResponse]
    let state: [StateResponse]
}

extension Item {
    init(from response: ItemResponse) {
        self.id = response.id
        self.name = response.name
        self.brandName = response.brand
        self.price = response.price
        self.description = response.description
        self.photoURL = URL(string: response.variants.first?.photoUrl ?? "")
        self.clothesType = ClothesType(rawValue: response.type) ?? .none
        self.clothesSubtype = ClothesSubtype(rawValue: response.subtype ?? "") ?? .none
        self.state = response.state.compactMap({ItemState(rawValue: $0.rawValue)})
    }
}

