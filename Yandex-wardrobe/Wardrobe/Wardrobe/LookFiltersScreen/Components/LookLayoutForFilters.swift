import SwiftUI

struct LookLayoutForFilters: View {
    let look: Look
    private let squareSize: CGFloat = 175
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .frame(width: squareSize + 12, height: squareSize + 6)
            
            if look.items.count > 3 {
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
                                AsyncImage(url: shoeItem.photoURL) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(maxHeight: squareSize / 2 - 7.5)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } placeholder: { ProgressView() }

                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.9))
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
                                .fill(Color.itemBackground)
                                .frame(width: squareSize / 2 - 2.5, height: squareSize)
                            AsyncImage(url: item.photoURL) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: squareSize / 2 - 7.5, height: squareSize - 10)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: { ProgressView() }
                        }
                    }
                    if look.items.count == 1 {
                        Color.clear.frame(width: squareSize / 2 - 2.5, height: squareSize)
                    }
                }
            } else {
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
                                    .fill(Color.gray.opacity(0.3))
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
    }
}
