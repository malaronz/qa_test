import Foundation

enum ItemState: String {
    case liked
    case bought
    case bucket
    case chosen
}

struct Item: Identifiable {
    let id: Int
    let photoURL: URL?
    let name: String
    let brandName: String
    let price: Double
    let description: String
    let clothesType: ClothesType
    let clothesSubtype: ClothesSubtype
    let state: [ItemState]
}

extension Item {
    static func skeletons(for type: ClothesType, countPerSubtype: Int = 1) -> [Item] {
        var result: [Item] = []
        var idCounter = 1

        for subtype in type.availableSubtypes {
            for _ in 0..<countPerSubtype {
                let item = Item(
                    id: idCounter,
                    photoURL: nil,
                    name: "Загрузка...",
                    brandName: "Бренд...",
                    price: 0.0,
                    description: "Описание...",
                    clothesType: type,
                    clothesSubtype: subtype,
                    state: []
                )
                result.append(item)
                idCounter += 1
            }
        }

        return result
    }
    static var skeletons: [Item] {
        ClothesType.allCases
            .filter { $0 != .none }
            .flatMap { skeletons(for: $0, countPerSubtype: 2) }
    }
}
