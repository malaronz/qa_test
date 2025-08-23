import SwiftUI

struct AvatarGradientRingView: View {
    let emoji: String
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    DesignTokens.Colors.popupBackground,
                    lineWidth: DesignTokens.Colors.avatarBorderWidth
                )
                .frame(
                    width: DesignTokens.ComponentSize.avatarSize,
                    height: DesignTokens.ComponentSize.avatarSize
                )
            Circle()
                .strokeBorder(
                    LinearGradient(
                        stops: DesignTokens.Colors.gradientStops,
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    lineWidth: DesignTokens.Colors.avatarBorderWidth
                )
                .frame(
                    width: DesignTokens.ComponentSize.avatarBorderSize,
                    height: DesignTokens.ComponentSize.avatarBorderSize
                )
            Text(emoji)
                .font(.system(size: DesignTokens.ComponentSize.avatarEmojiFontSize))
        }
    }
}
