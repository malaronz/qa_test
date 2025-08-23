import SwiftUI

enum ItemCardState {
    case checkBox
    case ellipsis
}

struct ItemCardView: View {
    @Binding var state: ItemCardState
    @Binding var isSelected: Bool
    @Binding var isCarted: Bool
    var isBought: Bool
    var item: Item
    var isSkeleton: Bool
    var checkboxSize: CGFloat = 18
    var onDeleteTapped: (Item) -> Void = {_ in }
    var onMoveTapped: (Item) -> Void = {_ in }
    var onCreateLookTapped: (Item) -> Void = {_ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    Color.itemBackground
                        .frame(width: 136, height: 188)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    if isSkeleton {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 136, height: 188)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } else {
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
                }
                .frame(width: 136, height: 188)

                if isBought && !isSkeleton {
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
                        .frame(width: 50, height: 14)
                        .padding(.leading, 5.5)
                        .padding(.bottom, 7)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                }

                if !isSkeleton {
                    switch state {
                    case .checkBox:
                        Button(action: {
                            isSelected.toggle()
                        }) {
                            Checkbox(isSelected: isSelected, size: checkboxSize)
                                .frame(width: checkboxSize, height: checkboxSize)
                                .padding(5)
                                .padding(.trailing, 5)
                        }
                    case .ellipsis:
                        Menu {
                            Button(action: { onCreateLookTapped(item) }) {
                                Text("Собрать образ")
                            }
                            Button(action: { isCarted.toggle() }) {
                                Text(isCarted ? "Удалить из корзины" : "Добавить в корзину")
                            }
                            Button(action: { onMoveTapped(item) }) {
                                Text("Переложить в...")
                            }
                            Button(action: { onDeleteTapped(item) }) {
                                Text("Убрать из гардероба")
                            }
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
                    }
                }
            }
            .frame(width: 136, height: 188)

            Spacer().frame(height: 18)

            if isSkeleton {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 60, height: 14)
                    .cornerRadius(4)
            } else {
                Text("\(Int(item.price)) ₽")
                    .font(.custom("YS Text Bold", size: 16))
            }

            Spacer().frame(height: 9)

            if isSkeleton {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 13)
                    .cornerRadius(4)
                Spacer().frame(height: 2)
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 13)
                    .cornerRadius(4)
            } else {
                Text(item.brandName)
                    .font(.custom("YS Text Cond Heavy", size: 13))
                Spacer().frame(height: 2)
                Text(item.name)
                    .font(.custom("YS Text Medium", size: 13))
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
        clothesSubtype: .skirt,
        state: []
    )
    @State var state:ItemCardState = .ellipsis
    @State var isSelected = false
    @State var isCarted = false
    @State var isloading = false
    HStack(spacing: 16) {
        ItemCardView(state: $state, isSelected: $isSelected, isCarted: $isCarted, isBought: true, item: item, isSkeleton: isloading)
            .frame(width: 136, height: 257)
        ItemCardView(state: $state, isSelected: $isSelected, isCarted: $isCarted, isBought: false, item: item, isSkeleton: isloading)
            .frame(width: 136, height: 257)
    }
    .padding()
}

//
//struct ItemCardView: View {
//    @Binding var state: ItemCardState
//    @Binding var isSelected: Bool
//    @Binding var isCarted: Bool
//    var isBought: Bool
//    var item: Item
//    var isSkeleton: Bool = false  // <-- передаётся извне
//    var checkboxSize: CGFloat = 18
//    var onDeleteTapped: (Item) -> Void = {_ in }
//    var onMoveTapped: (Item) -> Void = {_ in }
//    var onCreateLookTapped: (Item) -> Void = {_ in }
//
//    @State private var isImageLoading = true
//
//    private var isLoading: Bool {
//        isSkeleton || isImageLoading
//    }
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            ZStack(alignment: .topTrailing) {
//                ZStack {
//                    Color.itemBackground
//                        .frame(width: 136, height: 188)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                    AsyncImage(url: item.photoURL) { phase in
//                        switch phase {
//                        case .empty:
//                            Color(.systemGray5)
//                                .onAppear { isImageLoading = true }
//
//                        case .success(let image):
//                            image
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: 136, height: 188)
//                                .clipped()
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .onAppear { isImageLoading = false }
//
//                        case .failure(_):
//                            Image(systemName: "photo")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 40, height: 40)
//                                .foregroundColor(.gray)
//                                .frame(width: 136, height: 188)
//                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .onAppear { isImageLoading = false }
//
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
//
//                    if isLoading {
//                        Rectangle()
//                            .fill(Color.gray.opacity(0.3))
//                            .frame(width: 136, height: 188)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                }
//                .frame(width: 136, height: 188)
//
//                if isBought && !isLoading {
//                    Text("КУПЛЕН")
//                        .font(.custom("YS Text Medium", size: 8))
//                        .foregroundColor(.itemBought)
//                        .padding(.horizontal, 5.48)
//                        .padding(.vertical, 2.9)
//                        .background(
//                            RoundedRectangle(cornerRadius: 5.48)
//                                .fill(Color.white)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 5.48)
//                                        .stroke(Color.itemBackground, lineWidth: 1.37)
//                                )
//                        )
//                        .frame(width: 50, height: 14)
//                        .padding(.leading, 5.5)
//                        .padding(.bottom, 7)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
//                }
//
//                if !isLoading {
//                    switch state {
//                    case .checkBox:
//                        Button(action: {
//                            isSelected.toggle()
//                        }) {
//                            Checkbox(isSelected: isSelected, size: checkboxSize)
//                                .frame(width: checkboxSize, height: checkboxSize)
//                                .padding(5)
//                                .padding(.trailing, 5)
//                        }
//
//                    case .ellipsis:
//                        Menu {
//                            Button(action: { onCreateLookTapped(item) }) {
//                                Text("Собрать образ")
//                            }
//                            Button(action: { isCarted.toggle() }) {
//                                Text(isCarted ? "Удалить из корзины" : "Добавить в корзину")
//                            }
//                            Button(action: { onMoveTapped(item) }) {
//                                Text("Переложить в...")
//                            }
//                            Button(action: { onDeleteTapped(item) }) {
//                                Text("Убрать из гардероба")
//                            }
//                        } label: {
//                            Image(systemName: "ellipsis")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 10, height: 10)
//                                .foregroundColor(.black)
//                                .frame(width: 18, height: 18)
//                                .background(Color.white)
//                                .clipShape(Circle())
//                                .padding(7)
//                        }
//                    }
//                }
//            }
//            .frame(width: 136, height: 188)
//
//            Spacer().frame(height: 18)
//
//            if isLoading {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 60, height: 14)
//                    .cornerRadius(4)
//            } else {
//                Text("\(Int(item.price)) ₽")
//                    .font(.custom("YS Text Bold", size: 16))
//            }
//
//            Spacer().frame(height: 9)
//
//            if isLoading {
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 80, height: 13)
//                    .cornerRadius(4)
//                Spacer().frame(height: 2)
//                Rectangle()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(width: 100, height: 13)
//                    .cornerRadius(4)
//            } else {
//                Text(item.brandName)
//                    .font(.custom("YS Text Cond Heavy", size: 13))
//                Spacer().frame(height: 2)
//                Text(item.name)
//                    .font(.custom("YS Text Medium", size: 13))
//            }
//        }
//    }
//}
