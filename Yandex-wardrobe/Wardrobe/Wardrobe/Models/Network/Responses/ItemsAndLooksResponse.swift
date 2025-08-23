struct ItemsAndLooksResponse: Decodable {
    let looks: [LookResponse]
    let allItems: [ItemResponse]
    let topItems: [ItemResponse]
    let bottomItems: [ItemResponse]
    let shoesItems: [ItemResponse]

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()

        looks = try container.decode([LookResponse].self)
        allItems = try container.decode([ItemResponse].self)
        topItems = try container.decode([ItemResponse].self)
        bottomItems = try container.decode([ItemResponse].self)
        shoesItems = try container.decode([ItemResponse].self)
    }
}

extension ItemsAndLooks {
    init(from response: ItemsAndLooksResponse) {
        self.looks = response.looks.map({Look(from: $0)})
        self.allItems = response.allItems.map({Item(from: $0)})
        self.topItems = response.topItems.map({Item(from: $0)})
        self.bottomItems = response.bottomItems.map({Item(from: $0)})
        self.shoesItems = response.shoesItems.map({Item(from: $0)})
    }
}
