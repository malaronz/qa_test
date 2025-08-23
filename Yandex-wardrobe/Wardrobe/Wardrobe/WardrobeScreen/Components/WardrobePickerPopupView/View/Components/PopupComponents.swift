import SwiftUI

struct PopupHandleBar: View {
    var body: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: DesignTokens.CornerRadius.small)
                .fill(DesignTokens.Colors.handleBarColor)
                .frame(
                    width: DesignTokens.ComponentSize.handleBarWidth,
                    height: DesignTokens.ComponentSize.handleBarHeight
                )
            Spacer()
        }
        .padding(.bottom, DesignTokens.Spacing.xxl)
    }
}

struct PopupHeader: View {
    var body: some View {
        Text(DesignTokens.Text.wardrobePickerTitle)
            .font(.system(size: DesignTokens.ComponentSize.headerFontSize, weight: .bold))
            .multilineTextAlignment(.leading)
            .padding(.bottom, DesignTokens.Spacing.medium + DesignTokens.Spacing.xs)
    }
}

struct SaveButton: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(DesignTokens.Text.saveButtonTitle)
                .font(.system(size: DesignTokens.ComponentSize.buttonFontSize, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: DesignTokens.ComponentSize.buttonHeight)
                .background(DesignTokens.Colors.saveButtonBackground)
                .foregroundStyle(Color.black)
                .cornerRadius(DesignTokens.CornerRadius.large)
        }
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.5)
    }
}
