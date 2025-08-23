import SwiftUI

struct LookImageView: View {
    var imageURL: URL?

    var body: some View {
        ZStack(alignment: .center) {
            Image(.lookImageViewBack)
                .resizable()
                .frame(width: 24, height: 24)
                .offset(x: -10, y: 0)
            Image(.lookImageViewFront)
                .resizable()
                .frame(width: 28, height: 28)
                .offset(x: -6, y: 0)

            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(width: 32, height: 32)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 32, height: 32)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .clipped()
                    case .failure(_):
                        fallbackImage
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 32, height: 32)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.white, lineWidth: 1)
                )
            } else {
                fallbackImage
            }
        }
    }

    private var fallbackImage: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundColor(.gray)
            .frame(width: 32, height: 32)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    VStack(spacing: 20) {
        LookImageView(imageURL: URL(string: "https://adventurica.ru/media/product/15908/15908_1.jpg"))
        LookImageView(imageURL: nil)
    }
}
