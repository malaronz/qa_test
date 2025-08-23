struct FilterRequest: Encodable {
    let filtersAll: ItemFilterRequest?
    let filtersTop: ItemFilterRequest?
    let filtersBottom: ItemFilterRequest?
    let filtersShoes: ItemFilterRequest?
    let filtersLook: LookFilterRequest?

    enum CodingKeys: String, CodingKey {
        case filtersAll = "filters_all"
        case filtersTop = "filters_top"
        case filtersBottom = "filters_bottom"
        case filtersShoes = "filters_shoes"
        case filtersLook = "filters_look"
    }
}

struct ItemFilterRequest: Encodable {
    let filters: ItemFilters
}

struct ItemFilters: Encodable {
    let type: [String]?
    let subtype: [String]?
    let variants: VariantsFilter?
}

struct VariantsFilter: Encodable {
    let size: [String]?
    let color: [String]?
    let gender: [String]?
}

struct LookFilterRequest: Encodable {
    let filters: LookFilters
}

struct LookFilters: Encodable {
    let season: [String]?
    let style: [String]?
    let reason: [String]?
}


extension FilterRequest {
    init(from domain: Filter) {
        self.filtersTop = domain.top.map { $0.asRequest() }
        self.filtersBottom = domain.bottom.map { $0.asRequest() }
        self.filtersShoes = domain.shoes.map { $0.asRequest() }
        self.filtersAll = domain.all.map { $0.asRequest() }
        self.filtersLook = domain.look.map { $0.asRequest() }
    }
}

extension ItemFilter {
    func asRequest() -> ItemFilterRequest {
        return ItemFilterRequest(
            filters: ItemFilters(
                type: types.map { $0.rawValue
                },
                subtype: subtypes.map { $0.rawValue },
                variants: VariantsFilter(
                    size: variants.size,
                    color: variants.color,
                    gender: variants.gender
                )
            )
        )
    }
}

extension LookFilter {
    func asRequest() -> LookFilterRequest {
        return LookFilterRequest(
            filters:
                LookFilters(
                    season: self.season,
                    style: self.style,
                    reason: self.reason
                )
        )
    }
}
