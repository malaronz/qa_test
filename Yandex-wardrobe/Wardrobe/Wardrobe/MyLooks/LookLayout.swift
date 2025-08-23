import SwiftUI

struct LookLayout: View {
    let look: Look
    private let squareSize: CGFloat = 175 // Match AddALookView and grid item size
    
    var body: some View {
        NavigationLink(destination: LookView(look: look)) {
            VStack(alignment: .leading, spacing: 3) {
                ZStack {
                    // No background for the grid item (transparent)
                    if look.items.count > 3 {
                        HStack(spacing: 5) {
                            if let bottomItem = look.items.first(where: { $0.clothesType == .bottom }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.itemBackground) // Gray background for individual image
                                        .frame(maxHeight: squareSize)
                                    AsyncImage(url: bottomItem.photoURL) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(maxHeight: squareSize - 10) // Slightly smaller to fit within background
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: { ProgressView() }
                                }
                            }
                            VStack(spacing: 5) {
                                if let topItem = look.items.first(where: { $0.clothesType == .top }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.itemBackground) // Gray background for individual image
                                            .frame(maxHeight: squareSize / 2 - 2.5)
                                        AsyncImage(url: topItem.photoURL) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: squareSize / 2 - 7.5) // Slightly smaller
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        } placeholder: { ProgressView() }
                                    }
                                }
                                if let shoeItem = look.items.first(where: { $0.clothesType == .shoes }) {
                                    ZStack {
                                        AsyncImage(url: shoeItem.photoURL) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: squareSize / 2 - 7.5)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        } placeholder: { ProgressView() }

                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.gray.opacity(0.9)) // make more visible
                                            .frame(maxHeight: squareSize / 2 - 7.5)

                                        Text("+\(look.items.count - 3)")
                                            .font(.custom("YS Text Bold", size: 30))
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    } else if look.items.count <= 2 {
                        HStack(spacing: 5) {
                            ForEach(look.items.prefix(2), id: \.id) { item in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.itemBackground) // Gray background for individual image
                                        .frame(width: squareSize / 2 - 2.5, height: squareSize)
                                    AsyncImage(url: item.photoURL) { image in
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: squareSize / 2 - 7.5, height: squareSize - 10) // Slightly smaller
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: { ProgressView() }
                                }
                            }
                            if look.items.count == 1 {
                                Color.clear.frame(width: squareSize / 2 - 2.5, height: squareSize)
                            }
                        }
                    }
                        else {
                            HStack(spacing: 5) {
                                if let bottomItem = look.items.first(where: { $0.clothesType == .bottom }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.itemBackground)
                                            .frame(maxHeight: squareSize)
                                        AsyncImage(url: bottomItem.photoURL) { image in
                                            image.resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: squareSize - 10)
                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                        } placeholder: { ProgressView() }
                                    }
                                }
                                VStack(spacing: 5) {
                                    if let topItem = look.items.first(where: { $0.clothesType == .top }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.itemBackground)
                                                .frame(maxHeight: squareSize / 2 - 2.5)
                                            AsyncImage(url: topItem.photoURL) { image in
                                                image.resizable()
                                                    .scaledToFit()
                                                    .frame(maxHeight: squareSize / 2 - 7.5)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            } placeholder: { ProgressView() }
                                        }
                                    }
                                    if let shoeItem = look.items.first(where: { $0.clothesType == .shoes }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.gray.opacity(0.3)) // ✅ background for third item
                                                .frame(maxHeight: squareSize / 2 - 2.5)
                                            AsyncImage(url: shoeItem.photoURL) { image in
                                                image.resizable()
                                                    .scaledToFit()
                                                    .frame(maxHeight: squareSize / 2 - 7.5)
                                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                            } placeholder: { ProgressView() }
                                        }
                                    }
                                }
                            }
                        }
                }
                .frame(width: squareSize, height: squareSize)
                .padding(5)
                
                Text(look.name)
                    .font(.custom("YS Text Bold", size: 15))
                    .multilineTextAlignment(.leading)
                Text("\(look.items.count) items") // Updated to show item count + "items"
                    .font(.custom("YS Text Medium", size: 12))
                    .multilineTextAlignment(.leading)
            }
            .frame(width: squareSize)
        }
        .buttonStyle(.plain)
    }
}

struct LookLayout_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LookLayout(look: WardrobeService().wardrobes[0].looks[2]) // 3 items
            LookLayout(look: WardrobeService().wardrobes[0].looks[1]) // 4 items
            LookLayout(look: WardrobeService().wardrobes[0].looks[0]) // 2 items
        }
    }
}
