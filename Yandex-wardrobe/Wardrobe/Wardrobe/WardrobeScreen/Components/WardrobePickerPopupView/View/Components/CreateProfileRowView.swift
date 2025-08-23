import SwiftUI

struct CreateProfileRowView: View {
    let placeholderEmoji: String
    let isEditing: Bool
    let validationMessage: String?
    let shakeToken: CGFloat
    
    @Binding var newProfileName: String
    
    let onEditTap: () -> Void
    let onEditingCancel: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: DesignTokens.Spacing.small) {
            rowContent
            
            if let validationMessage, isEditing {
                ValidationMessageView(message: validationMessage)
            }
        }
    }
    
    private var rowContent: some View {
        HStack(spacing: DesignTokens.Spacing.large) {
            ProfileAvatarView(
                emoji: placeholderEmoji,
                isSelected: false,
                showsSelectionBadge: false
            )
            
            if isEditing {
                EditingTextFieldView(
                    text: $newProfileName,
                    shakeToken: shakeToken
                )
            } else {
                CreateProfilePlaceholderView()
            }
            
            EditButtonView(
                isEditing: isEditing,
                onEditTap: onEditTap,
                onEditingCancel: onEditingCancel
            )
        }
        .padding(DesignTokens.Padding.content)
        .background(DesignTokens.Colors.rowBackground)
        .cornerRadius(DesignTokens.CornerRadius.large)
        .contentShape(Rectangle())
        .frame(height: DesignTokens.ComponentSize.rowHeight)
    }
}

struct CreateProfilePlaceholderView: View {
    var body: some View {
        Text(DesignTokens.Text.newUserPlaceholder)
            .foregroundStyle(DesignTokens.Colors.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
