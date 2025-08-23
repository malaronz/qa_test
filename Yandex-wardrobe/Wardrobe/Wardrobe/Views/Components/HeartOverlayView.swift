import SwiftUI

struct HeartOverlayView: View {
    var isLiked: Bool
    var body: some View {
        Image(isLiked ? .likeOn : .likeOff)
        .frame(width: 24, height: 24)
    }
}

#Preview {
    HeartOverlayView(isLiked: false)
}
