import SwiftUI

struct ExistingLookView: View {
    let look: Look
    var body: some View {
        HStack {
            LookImageView(
                imageURL: look.items.first(where: { $0.clothesType == .top })?.photoURL ?? look.items.first?.photoURL
            )
            Text(look.name)
                .font(.custom("YS Text Medium", size: 13))
                .foregroundStyle(.wardrobeBlack)
        }
        .padding(8)
        .padding(.leading, 7)
        .frame(height: 56)
        .background(.chevronBackground)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ExistingLookView(
        look: Look(
            id: 1, name: "Выпускной",
            items: [
                Item(
                    id: 1,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .top, clothesSubtype: .skirt, state: []),
                Item(
                    id: 2,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .bottom, clothesSubtype: .skirt, state: []),
                Item(
                    id: 3,photoURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .shoes, clothesSubtype: .skirt, state: [])
            ]
        )
    )
}
