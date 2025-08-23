struct WardrobeResponse: Decodable {
    let id: Int
    let name: String?
    let lookArray: [LookResponse]
    let userId: Int?
    let authorId: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case lookArray = "look_array"
        case userId = "user_id"
        case authorId = "author_id"
    }
}

extension Wardrobe {
    init(from response: WardrobeResponse) {
        self.id = response.id
        self.looks = response.lookArray.map({ Look(from: $0)})
        self.userId = response.userId ?? 1
    }
}
