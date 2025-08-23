import SwiftUI

struct ClothesSubtypeView: View {
    @Binding var isSelected: Bool
    var imageURL: URL?

    var body: some View {
        Group {
            if let imageURL = imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color(.systemGray5))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .background(Color.white)
                            .clipped()
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.gray)
                            .background(Color.white)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.gray)
                    .background(Color.white)
            }
        }
        .frame(width: 78.75, height: 78.75)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.wardrobeBlack : Color.wardrobeWhite, lineWidth: 3)
        )
    }
}

#Preview {
    @State var isSelected = true
    ClothesSubtypeView(isSelected: $isSelected, imageURL: nil)
}
