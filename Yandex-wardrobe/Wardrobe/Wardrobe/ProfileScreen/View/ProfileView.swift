import SwiftUI

struct ProfileView: View {
    @State private var balanceCards: [BalanceCard] = [.splitCard, .yPayCard]
    @State private var menuSections: [MenuSection] = [.purchasesSection, .benefitsSection, .myMarketSection]
    @State private var shouldNavigateToWardrobe = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spec.mainSpacing) {
                profileSection
                balanceSection
                menuSectionsView
            }
            .padding(.horizontal, Spec.largePadding)
        }
        .background(
            NavigationLink(
                destination: WardrobeView(),
                isActive: $shouldNavigateToWardrobe
            ) { EmptyView() }
        )
    }
    
    // MARK: - Profile Section
    @ViewBuilder
    private var profileSection: some View {
        ProfileSectionView()
    }
    
    // MARK: - Balance Section
    @ViewBuilder
    private var balanceSection: some View {
        HStack(spacing: Spec.largeSpacing) {
            ForEach(Array(balanceCards.enumerated()), id: \.element.id) { index, card in
                BalanceCardView(card: card)
                    .padding(.leading, index == .zero ? Spec.largePadding : .zero)
            }
        }
        .padding(.top, Spec.topPadding)
    }
    
    // MARK: - Menu Sections
    @ViewBuilder
    private var menuSectionsView: some View {
        VStack(spacing: Spec.mainSpacing) {
            ForEach(menuSections) { section in
                MenuSectionView(
                    section: section,
                    showingWardrobe: $shouldNavigateToWardrobe
                )
            }
        }
        .padding(.top, Spec.sectionTopPadding)
    }
}

#Preview {
    ProfileView()
}

private enum Spec {
    // MARK: - Spacing
    static let mainSpacing: CGFloat = 16
    static let largeSpacing: CGFloat = 26
    
    // MARK: - Padding
    static let largePadding: CGFloat = 16
    static let topPadding: CGFloat = 10
    static let sectionTopPadding: CGFloat = 28
}
