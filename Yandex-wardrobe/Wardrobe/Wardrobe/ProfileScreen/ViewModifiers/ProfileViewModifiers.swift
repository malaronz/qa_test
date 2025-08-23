import SwiftUI

struct SectionHeaderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: Spec.mediumFontSize, weight: .medium))
            .foregroundColor(Spec.secondaryColor)
            .padding(.vertical, Spec.sectionHeaderPadding)
            .padding(.horizontal, Spec.horizontalPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Spec.secondaryBackgroundColor)
            .cornerRadius(Spec.cornerRadius)
    }
}

struct BadgeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: Spec.mediumFontSize, weight: .medium))
            .foregroundColor(Spec.secondaryColor)
            .padding(.horizontal, Spec.horizontalPadding)
            .padding(.vertical, Spec.badgeVerticalPadding)
            .background(Spec.secondaryBackgroundColor)
            .clipShape(Circle())
    }
}

// MARK: - View Extensions
extension View {
    func sectionHeader() -> some View { 
        modifier(SectionHeaderModifier()) 
    }
    
    func badge() -> some View { 
        modifier(BadgeModifier()) 
    }
}

private enum Spec {
    // MARK: - Font Sizes
    static let smallFontSize: CGFloat = 12
    static let mediumFontSize: CGFloat = 13
    static let largeFontSize: CGFloat = 16
    
    // MARK: - Paddings
    static let sectionHeaderPadding: CGFloat = 5
    static let horizontalPadding: CGFloat = 8
    static let badgeVerticalPadding: CGFloat = 4
    
    // MARK: - Corner Radius
    static let cornerRadius: CGFloat = 6
    
    // MARK: - Colors
    static let secondaryColor = Color.secondary
    static let secondaryBackgroundColor = Color(.secondarySystemBackground).opacity(0.5)
}
