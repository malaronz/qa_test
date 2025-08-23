import SwiftUI

struct CarouselItemCard: View {
    @Binding var isSelected: Bool
    @State var isCarted: Bool
    var item: Item
    var isBought: Bool
    var checkboxSize: CGFloat = 24
    var isLoading: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isLoading {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
                    .frame(width: 136, height: 188)

                Spacer().frame(height: 10)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(width: 60, height: 16)

                Spacer().frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray5))
                    .frame(width: 80, height: 13)
            } else {
                ZStack(alignment: .topTrailing) {
                    ZStack {
                        Color.white
                            .frame(width: 136, height: 188)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        AsyncImage(url: item.photoURL) { phase in
                            switch phase {
                            case .empty:
                                Rectangle()
                                    .fill(Color(.systemGray5))
                                    .frame(width: 136, height: 188)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 136, height: 188)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))

                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.gray)

                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    .frame(width: 136, height: 188)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    if isBought {
                        Text("КУПЛЕН")
                            .font(.custom("YS Text Medium", size: 8))
                            .foregroundColor(.itemBought)
                            .padding(.horizontal, 5.48)
                            .padding(.vertical, 2.9)
                            .background(
                                RoundedRectangle(cornerRadius: 5.48)
                                    .fill(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5.48)
                                            .stroke(Color.itemBackground, lineWidth: 1.37)
                                    )
                            )
                            .frame(width: 50, height: 14, alignment: .center)
                            .padding(.leading, 5.5)
                            .padding(.bottom, 14)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    }

                    Button(action: {
                        isCarted.toggle()
                    }) {
                        Image(.basketFilled)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(isCarted ? .checkboxOn : .white)
                            .clipShape(Circle())
                            .shadow(
                                color: Color.black.opacity(0.1),
                                radius: 6,
                                x: 0,
                                y: 3
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 6.5)

                    Button(action: {
                        isSelected.toggle()
                    }) {
                        Checkbox(isSelected: isSelected, size: checkboxSize)
                            .frame(width: checkboxSize, height: checkboxSize)
                            .padding(5)
                            .padding(.trailing, 5)
                    }
                }
                .frame(width: 136, height: 195)

                Spacer().frame(height: 1)

                Text("\(Int(item.price)) ₽")
                    .font(.custom("YS Text Bold", size: 16))
                    .foregroundStyle(.wardrobeBlack)

                Spacer().frame(height: 6)

                Text(item.brandName)
                    .font(.custom("YS Text Medium", size: 13))
                    .foregroundStyle(.wardrobeBlack)
            }
        }
    }
}

#Preview {
    let item = Item(
        id: 1,
        photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5129282/2a000001944f77f63a3bcd0e415fd58621f6/optimize")!,
        name: "Кепка для велоспорта",
        brandName: "MUSEUM OF PEACE",
        price: 542,
        description: "",
        clothesType: .top,
        clothesSubtype: .aquaShoes,
        state: []
    )
    @State var isSelected = false
    HStack(spacing: 16) {
        CarouselItemCard(isSelected: $isSelected, isCarted: false, item: item, isBought: true)
            .frame(width: 136, height: 232)
        CarouselItemCard(isSelected: $isSelected, isCarted: false, item: item, isBought: false)
            .frame(width: 136, height: 232)
    }
    .padding()
}

