import SwiftUI

struct ProfileAvatarView: View {
    let emoji: String
    let isSelected: Bool
    let showsSelectionBadge: Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AvatarGradientRingView(emoji: emoji)
            
            if showsSelectionBadge && isSelected {
                SelectionBadgeView()
            }
        }
    }
}

struct SelectionBadgeView: View {
    var body: some View {
        Image(.selectedProfile)
            .resizable()
            .frame(
                width: DesignTokens.ComponentSize.avatarBadgeSize,
                height: DesignTokens.ComponentSize.avatarBadgeSize
            )
            .offset(
                x: DesignTokens.ComponentSize.avatarBadgeOffset,
                y: DesignTokens.ComponentSize.avatarBadgeOffset
            )
    }
}
