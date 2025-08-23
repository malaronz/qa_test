import Foundation

struct Look {
    let id: Int
    let name: String
    let items: [Item]
    let season: String?
    let style: String?
    let reason: String?

    init(id: Int, name: String, items: [Item], season: String? = nil, style: String? = nil, reason: String? = nil) {
        self.id = id
        self.name = name
        self.items = items
        self.season = season
        self.style = style
        self.reason = reason
    }
}

extension Look {
    static func skeletons(count: Int = 3) -> [Look] {
        (0..<count).map { index in
            Look(
                id: index,
                name: "Образ",
                items: [],
                season: nil,
                style: nil,
                reason: nil
            )
        }
    }
}
