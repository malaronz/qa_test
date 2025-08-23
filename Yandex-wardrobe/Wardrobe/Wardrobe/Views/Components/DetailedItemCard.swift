import SwiftUI

struct DetailedItemCardView: View {
    var item: Item
    @State var isLiked: Bool
    @Binding var isCarted: Bool
    var isBought: Bool
    var deliveryTime: String = "Завтра"
    var shopName: String = "Meizu official store"
    var onShopTapped: () -> Void = {}
    var pickupChoice: String = "ПВЗ"
    var isLoading: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isLoading {
                skeletonView
            } else {
                loadedView
            }
        }
    }

    private var skeletonView: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 179.5, height: 229)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 100, height: 20)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 140, height: 14)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 14)

            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 160, height: 14)
        }
        .frame(width: 179.5)
        .redacted(reason: .placeholder)
    }

    private var loadedView: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    Color.itemBackground
                        .frame(width: 179.5, height: 229)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    AsyncImage(url: item.photoURL) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color(.systemGray5))
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 179.5, height: 229)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Menu {
                    Button(action: {}) { Text("Собрать образ") }
                    Button(action: {}) { Text("Переложить в...") }
                    Button(action: {}) { Text("Убрать из гардероба") }
                } label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                        .frame(width: 18, height: 18)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(7)
                }
                .padding(.top, 5)
                .padding(.trailing, 4.5)

                if isBought {
                    Text("КУПЛЕН")
                        .font(.system(size: 12, weight: .bold))
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
                        .frame(width: 64, height: 20, alignment: .center)
                        .padding(.leading, 5.5)
                        .padding(.bottom, 24)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }

                Button(action: {
                    isCarted.toggle()
                }) {
                    Image(.basketFilled)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(10)
                        .background(isCarted ? .checkboxOn : .white)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.trailing, 6.5)
            }

            Text("\(Int(item.price)) ₽")
                .font(.custom("YS Text Bold", size: 20))

            Spacer().frame(height: 5)

            Text("\(item.name) \(item.brandName)")
                .font(.custom("YS Text Bold", size: 13))
                .lineLimit(1)

            Spacer().frame(height: 2)

            deliveryInfo
        }
    }

    private var deliveryInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .fill(Color.deliveryInfoBlue)
                    .frame(width: 10, height: 10)
                Spacer().frame(width: 4)
                Text(deliveryTime)
                    .font(.custom("YS Text Bold", size: 11))
                Text(", по клику ·\(pickupChoice)")
                    .font(.custom("YS Text Regular", size: 11))
                    .foregroundStyle(.secondary)
            }
            Spacer().frame(height: 5)
            Button(action: onShopTapped) {
                HStack {
                    Image(.shop)
                    Spacer().frame(width: 4)
                    Text(shopName)
                        .font(.custom("YS Text Regular", size: 11))
                    Spacer().frame(width: 2)
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 3.6, height: 6)
                }
            }
            .buttonStyle(.plain)
            .foregroundStyle(.wardrobeBlack)
        }
    }
}

#Preview {
    let item = Item(
        id: 1,
        photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5129282/2a000001944f77f63a3bcd0e415fd58621f6/optimize")!,
        name: "Кепка для велоспорта",
        brandName: "MUSEUM OF PEACE",
        price: 52,
        description: "",
        clothesType: .top,
        clothesSubtype: .skirt,
        state: []
    )
    @State var isCarted = false
    HStack(spacing: 16) {
        DetailedItemCardView(item: item,isLiked: true, isCarted: $isCarted ,isBought: true)
            .frame(width: 179.5, height: 334)

    }
    .padding()
}
