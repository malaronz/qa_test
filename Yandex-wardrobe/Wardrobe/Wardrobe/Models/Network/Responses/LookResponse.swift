struct LookResponse: Decodable {
    let id: Int
    let name: String
    let items: [ItemResponse]
    let userId: Int
    let season: String?
    let style: String?
    let reason: String?

    enum CodingKeys: String, CodingKey {
        case id, name, items
        case userId = "user_id"
        case season, style, reason
    }
}

extension Look {
    init(from response: LookResponse) {
        self.name = response.name
        self.id = response.id
        self.items = response.items.map({ Item(from: $0)})
        self.reason = response.reason
        self.season = response.season
        self.style = response.style
    }
}
