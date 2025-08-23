struct LookBuilderRequest: Encodable {
    let items: [Int]
    let filtersTop: ItemFilterRequest?
    let filtersBottom: ItemFilterRequest?
    let filtersShoes: ItemFilterRequest?

    enum CodingKeys: String, CodingKey {
        case items
        case filtersTop = "filters_top"
        case filtersBottom = "filters_bottom"
        case filtersShoes = "filters_shoes"
    }
}
