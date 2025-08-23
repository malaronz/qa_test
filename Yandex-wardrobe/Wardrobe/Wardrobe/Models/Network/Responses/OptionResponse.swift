import Foundation

enum Gender: String, Decodable {
    case male
    case female
    case unisex
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let raw = try container.decode(String.self)
        self = Gender(rawValue: raw) ?? .unknown
    }
}

struct OptionResponse: Decodable {
    let color: String
    let gender: Gender//мб тут лучше будет стринг
    let amount: Int
    let size: String
    let photoUrl: String

    enum CodingKeys: String, CodingKey {
        case color
        case gender
        case amount
        case size
        case photoUrl = "url_photo"
    }
}
