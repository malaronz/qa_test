import SwiftUI

enum DesignTokens {
    
    // MARK: - Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let small: CGFloat = 6
        static let medium: CGFloat = 8
        static let large: CGFloat = 12
        static let xl: CGFloat = 16
        static let xxl: CGFloat = 24
    }
    
    // MARK: - Padding
    enum Padding {
        static let horizontal: CGFloat = 16
        static let vertical: CGFloat = 8
        static let top: CGFloat = 6
        static let content: CGFloat = 12
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 4
        static let medium: CGFloat = 12
        static let large: CGFloat = 20
    }
    
    // MARK: - Components Sizes
    enum ComponentSize {
        // Handle Bar
        static let handleBarWidth: CGFloat = 34
        static let handleBarHeight: CGFloat = 4
        
        // Buttons
        static let buttonHeight: CGFloat = 64
        
        // Rows
        static let rowHeight: CGFloat = 72
        
        // Avatar
        static let avatarSize: CGFloat = 40
        static let avatarBorderSize: CGFloat = 44
        static let avatarBadgeSize: CGFloat = 20
        static let avatarBadgeOffset: CGFloat = 6
        
        // Font Sizes
        static let headerFontSize: CGFloat = 20
        static let buttonFontSize: CGFloat = 16
        static let avatarEmojiFontSize: CGFloat = 24
    }
    
    // MARK: - Colors
    enum Colors {
        static let saveButtonBackground = Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0))
        static let handleBarColor = Color(UIColor.systemGray3)
        static let rowBackground = Color(UIColor.secondarySystemBackground)
        static let popupBackground = Color(UIColor.systemBackground)
        static let primaryText = Color.primary
        static let secondaryText = Color.gray
        static let errorText = Color.red
        static let avatarBorderWidth: CGFloat = 2
        
        // Gradient colors (keeping existing design)
        static let gradientColors = [
            Color.linearOrange,
            Color.linearPink,
            Color.linearPurple,
            Color.linearBlue
        ]
        
        static let gradientStops: [Gradient.Stop] = [
            .init(color: .linearOrange, location: 0.0),
            .init(color: .linearPink, location: 0.30),
            .init(color: .linearPurple, location: 0.75),
            .init(color: .linearBlue, location: 1.0)
        ]
    }
    
    // MARK: - Text
    enum Text {
        static let wardrobePickerTitle = "Выберите гардероб"
        static let newUserPlaceholder = "Новый пользователь"
        static let saveButtonTitle = "Сохранить"
        static let textFieldPlaceholder = "Введите имя"
        
        // Validation messages
        enum Validation {
            static let emptyName = "Введите имя"
            static let nameTooLong = "Слишком длинное имя"
            static let nameAlreadyExists = "Имя уже занято"
            static let invalidCharacters = "Разрешены буквы, цифры и пробел"
        }
    }
    
    // MARK: - Constraints
    enum Constraints {
        static let maxProfiles = 10
        static let maxNameLength = 30
        static let estimatedVerticalPadding: CGFloat = 16
    }
}
