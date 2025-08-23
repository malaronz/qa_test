import SwiftUI

struct WardrobeHeaderView: View {
    let looks: [Look]
    let onChevronTap: () -> Void
    let onNewLookTap: () -> Void
    let onLookTap: (Look) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            headerSection
            if looks.isEmpty {
                newLookSection
            } else {
                existingLooksSection
            }

        }
        .background(.wardrobeWhite)
        .cornerRadius(24)
    }

    private var headerSection: some View {
        HStack {
            Text("Готовые образы")
                .font(.custom("YS Text Bold", size: 20))
            Spacer()
            NavigationLink(destination: MyLooksView()) {
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.wardrobeBlack)
                    .padding(8)
                    .background(Color.chevronBackground)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal,16)
        .padding(.top, 12)
    }

    private var newLookSection: some View {
        HStack {
            Button(action: onNewLookTap) {
                Image(.newButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.wardrobeBlack)
                    .padding(16)
                    .background(Color.chevronBackground)
                    .cornerRadius(16)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Новый образ")
                    .font(.custom("YS Text Medium", size: 16))
                Text("Соберите образ с помощью алгоритмов")
                    .font(.custom("YS Text Medium", size: 13))
                    .lineLimit(1)
            }
        }
        .padding(.horizontal,16)
        .padding(.bottom, 16)
    }

    private var existingLooksSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Button(action: onNewLookTap) {
                    Image(.newButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.wardrobeBlack)
                        .padding(16)
                        .background(Color.chevronBackground)
                        .cornerRadius(16)
                }
                ForEach(looks, id: \.id) { look in
                    NavigationLink(destination: LookView(look: look)) {
                        ExistingLookView(look: look)
                    }
                    .foregroundStyle(.black)
                }
            }
        }
        .padding(.horizontal,16)
        .padding(.bottom, 16)
    }

    private var justIncase: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(looks, id: \.id) { look in
                    Button(action: { onLookTap(look) }) {
                        LookLayout(look: look)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
        .padding(.horizontal,8)
        .padding(.bottom, 16)
    }
}

//#Preview {
//    WardrobeHeaderView(
//        looks: [
//            Look(
//                id: 1, name: "Выпускной",
//                items: [
//                    Item(
//                        id: 1,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/11395611/img_id5444242524261206856.jpeg/180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .top, clothesSubtype: .skirt),
//                    Item(
//                        id: 2,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/15300889/2a000001955b652e2e39e1a3d3535eb0ba05/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .bottom, clothesSubtype: .skirt),
//                    Item(
//                        id: 3,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5454584/img_id3839165585273224377.jpeg/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .shoes, clothesSubtype: .skirt)
//                ]
//            ),
//            Look(
//                id: 2, name: "Офисссс",
//                items: [
//                    Item(
//                        id: 4,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .top, clothesSubtype: .skirt),
//                    Item(
//                        id: 5,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .bottom, clothesSubtype: .skirt),
//                    Item(
//                        id: 6,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .shoes, clothesSubtype: .skirt)
//                ]
//            ),
//            Look(
//                id: 3, name: "Выпускной",
//                items: [
//                    Item(
//                        id: 7,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/11395611/img_id5444242524261206856.jpeg/180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .top, clothesSubtype: .skirt),
//                    Item(
//                        id: 8,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/15300889/2a000001955b652e2e39e1a3d3535eb0ba05/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .bottom, clothesSubtype: .skirt),
//                    Item(
//                        id: 9,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5454584/img_id3839165585273224377.jpeg/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,sizes: [:],description: "",clothesType: .shoes, clothesSubtype: .skirt)
//                ]
//            )
//
//        ],
//        onChevronTap: {
//        },
//        onNewLookTap: {},
//        onLookTap: {_ in})
//}
