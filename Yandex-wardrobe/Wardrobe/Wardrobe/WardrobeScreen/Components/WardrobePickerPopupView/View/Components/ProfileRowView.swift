import SwiftUI

struct ProfileRowView: View {
    let profile: Profile
    let isSelected: Bool
    let isEditing: Bool
    let validationMessage: String?
    let shakeToken: CGFloat
    
    @Binding var editingText: String
    
    let onTap: (() -> Void)?
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
                emoji: profile.emoji,
                isSelected: isSelected,
                showsSelectionBadge: true
            )
            
            if isEditing {
                EditingTextFieldView(
                    text: $editingText,
                    shakeToken: shakeToken
                )
            } else {
                ProfileNameView(name: profile.name)
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
        .onTapGesture { onTap?() }
        .frame(height: DesignTokens.ComponentSize.rowHeight)
    }
}

// MARK: - Supporting Views

struct ProfileNameView: View {
    let name: String
    
    var body: some View {
        Text(name)
            .foregroundStyle(DesignTokens.Colors.primaryText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct EditingTextFieldView: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    let shakeToken: CGFloat
    
    var body: some View {
        TextField(DesignTokens.Text.textFieldPlaceholder, text: $text)
            .focused($isFocused)
            .submitLabel(.done)
            .onSubmit { isFocused = false }
            .modifier(ShakeEffect(animatableData: shakeToken))
            .textInputAutocapitalization(.words)
            .disableAutocorrection(false)
            .onAppear { 
                DispatchQueue.main.async { 
                    isFocused = true 
                } 
            }
    }
}

struct EditButtonView: View {
    let isEditing: Bool
    let onEditTap: () -> Void
    let onEditingCancel: () -> Void
    
    var body: some View {
        Button(action: { isEditing ? onEditingCancel() : onEditTap() }) {
            Image(.pencil)
                .renderingMode(.template)
                .foregroundStyle(DesignTokens.Colors.secondaryText)
        }
    }
}

struct ValidationMessageView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.caption)
            .foregroundStyle(DesignTokens.Colors.errorText)
    }
}
