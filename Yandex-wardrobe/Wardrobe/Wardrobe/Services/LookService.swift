import Foundation

final class LookService {
    private let networkClient = NetworkClient()

    func getLook(withId id: Int) async throws -> Look {//fake
        WardrobeService().wardrobes.first!.looks[id]
    }

    func createLook(look: Look, wardrobeId: Int = Constants.wardrobeId, userId: Int = Constants.userId) async throws -> Look {//real
        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/wardrobe/\(wardrobeId)/create_look") else {
            throw ServiceError.invalidRequest
        }
        print(734865873468457)
        let request = CreateLookRequest(name: look.name, id: look.items.map(\.id))
        let response = try await networkClient
            .request(url: url, method: .post, requestBody: request, responseType: LookResponse.self)//как узнать ID нового лука
        print(response)
        return Look(from: response)
    }

    func deleteLook(withId id: Int, wardrobeId: Int = Constants.wardrobeId, userId: Int = Constants.userId) async throws {//real

        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/\(wardrobeId)/\(id)") else {
            throw ServiceError.invalidRequest
        }

        let _ = try await networkClient
            .request(url: url, method: .delete)
    }

    func updateLook(look: Look, wardrobeId: Int = Constants.wardrobeId, userId: Int = Constants.userId) async throws -> Look {//real
        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/wardrobe/\(wardrobeId)/look/\(look.id)") else {
            throw ServiceError.invalidRequest
        }
        print(look.id)
        let request = UpdateLookRequest(from: look)
        let response = try await networkClient
            .request(url: url, method: .put, requestBody: request, responseType: LookResponse.self)
        return Look(from: response)
    }

    func lookBuilder(
        items: [Int],
        filter: Filter,
        wardrobeId: Int = Constants.wardrobeId,
        userId: Int = Constants.userId
    ) async throws -> [[Item]] {
        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/wardrobe/\(wardrobeId)/look_constructor") else {
            throw ServiceError.invalidRequest
        }
        print(Array(Set(items)))
        let request = LookBuilderRequest(
            items: Array(Set(items)),
            filtersTop: filter.top?.asRequest(),
            filtersBottom: filter.bottom?.asRequest(),
            filtersShoes: filter.shoes?.asRequest()
        )

        let response = try await networkClient.request(
            url: url,
            method: .post,
            requestBody: request,
            responseType: [[ItemResponse]].self
        )

        return response.map { group in
            group.map { Item(from: $0) }
        }
    }
}
