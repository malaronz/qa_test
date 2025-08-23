struct CreateLookRequest: Encodable {
    let name: String
    let id: [Int]
}

struct UpdateLookRequest: Encodable {
    let ids: [Int]
    let name: String
    let season: String?
    let reason: String?
    let style: String?
}

extension UpdateLookRequest {
    init(from domain: Look) {
        self.ids = domain.items.map(\.id)
        self.name = domain.name
        self.season = domain.season ?? ""
        self.reason = domain.reason ?? ""
        self.style = domain.style ?? ""
    }
}
