struct AddToCartResponse: Decodable {
    let success: Bool
    let message: String
    let userId: String?
    let addedItems: [Int]

    enum CodingKeys: String, CodingKey {
        case success
        case message
        case userId = "user_id"
        case addedItems = "added_items"
    }
}
