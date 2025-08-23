import Foundation

final class WardrobeService {
    private let networkClient = NetworkClient()
    var wardrobes: [Wardrobe] = [
        Wardrobe(
            id: Constants.wardrobeId,
            looks: [
                Look(
                    id: 0, name: "Выпускной",
                    items: [
                        Item(
                            id: 20,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/12281819/2a000001939d049aed47f2f1b7a68ec7e9fe/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .bottom, clothesSubtype: .skirt, state: [.bought]),
                        Item(
                            id: 21,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/7430655/img_id377678520659478507.png/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .shoes, clothesSubtype: .aquaShoes, state: [.bucket])
                    ]
                ),
                Look(
                    id: 1, name: "Офис",
                    items: [
                        Item(
                            id: 22,photoURL: URL(string: "https://avatars.mds.yandex.net//get-mpic//5262552//2a0000019224720e1d1d83e5a300454c4263//180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .top, clothesSubtype: .skirt, state: []),
                        Item(
                            id: 28,photoURL: URL(string: "https://avatars.mds.yandex.net//get-mpic//5262552//2a0000019224720e1d1d83e5a300454c4263//180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .top, clothesSubtype: .tShirt, state: []),
                        Item(
                            id: 23,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/1374520/2a000001927e9f70ee6e69f9306ff280004d/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .bottom, clothesSubtype: .trousers, state: []),
                        Item(
                            id: 24,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5235242/img_id7152666360681962112.png/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .shoes, clothesSubtype: .aquaShoes, state: [])
                    ]
                ),
                Look(
                    id: 2, name: "Спортивная одежда",
                    items: [
                        Item(
                            id: 25,photoURL: URL(string: "https://avatars.mds.yandex.net//get-mpic//1332324//2a000001919295a4fb01ef996f3f651650bc//180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .top, clothesSubtype: .skirt, state: []),
                        Item(
                            id: 26,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/12280362/2a000001944b2ae723d400e60d730d0cffdc/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .bottom, clothesSubtype: .trousers, state: []),
                        Item(
                            id: 27,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5387588/img_id5077483725256516125.jpeg/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .shoes, clothesSubtype: .aquaShoes, state: [])
                    ]
                )
            ],
            userId: Constants.userId
        )]

    func getWardrobes(userId: Int = Constants.userId) async throws -> [Wardrobe] {//real but idk if needed
        return wardrobes

    }

    func getWardrobe(filter: Filter, withId id: Int = Constants.wardrobeId, userId: Int = Constants.userId) async throws -> Wardrobe {//real

        guard let url = URL(string: "\(Constants.baseUrl)/users/\(userId)/wardrobe/\(id)") else {
            throw ServiceError.invalidRequest
        }
        let request = FilterRequest(from: filter)
        let response = try await networkClient
            .request(url: url, method: .post, responseType: WardrobeResponse.self)

        return Wardrobe(from: response)
    }

}
