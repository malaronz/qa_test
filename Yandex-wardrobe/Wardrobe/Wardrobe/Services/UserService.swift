import Foundation

final class UserService {
    private let networkClient = NetworkClient()

    func addToCart(_ items: [Item], userId: Int = Constants.userId) async throws {//real
        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/basket") else {
            throw ServiceError.invalidRequest
        }
        let request = AddToCartRequest(id: items.map(\.id))
        let _ = try await networkClient
            .request(url: url, method: .post,requestBody: request, responseType: AddToCartResponse.self)

    }

    func startScreen(filter: Filter, wardrobeId: Int = Constants.wardrobeId, userId: Int = Constants.userId) async throws -> ItemsAndLooks {//real
        //return ItemsAndLooks(looks: WardrobeService().wardrobes[0].looks, allItems: WardrobeService().wardrobes[0].looks[0].items, topItems: [], bottomItems: [], shoesItems: [])
        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/wardrobe/\(wardrobeId)/start_screen") else {
            throw ServiceError.invalidRequest
        }
        let request = FilterRequest(from: filter)
        let response = try await networkClient
            .request(url: url, method: .post, responseType: ItemsAndLooksResponse.self)
        print(response.allItems.map({$0.subtype}),response.looks.count)
        return ItemsAndLooks(from: response)
    }

}
