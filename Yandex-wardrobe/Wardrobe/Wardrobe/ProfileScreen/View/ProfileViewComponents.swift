import SwiftUI

// MARK: - Profile Section View
struct ProfileSectionView: View {
    var body: some View {
        HStack(spacing: Spec.profileSpacing) {
            Image(.profilePhoto)
            
            VStack(alignment: .leading) {
                Text(Spec.profileName)
                    .font(.system(size: Spec.profileNameFontSize, weight: .medium))
                
                HStack(spacing: Spec.balanceLabelSpacing) {
                    Text(Spec.openProfileText)
                        .font(.system(size: Spec.profileSubtitleFontSize))
                        .foregroundColor(.secondary)
                    
                    Image(systemName: Spec.chevronRightIcon)
                        .font(.system(size: Spec.profileChevronSize))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            HStack(spacing: Spec.profileIconSpacing) {
                Image(.plusBadge)
                Image(.chat)
                    .renderingMode(.template)
            }
        }
    }
}

// MARK: - Balance Card View
struct BalanceCardView: View {
    let card: BalanceCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spec.balanceLabelSpacing) {
            HStack(spacing: Spec.balanceIconSpacing) {
                Image(card.icon)
                Text(card.amount)
                    .font(.system(size: Spec.balanceAmountFontSize, weight: .bold))
            }
            
            HStack(spacing: Spec.balanceLabelSpacing) {
                Group {
                    if card.label == Spec.cardText {
                        HStack(spacing: Spec.cardTextSpacing) {
                            Text(Spec.cardText)
                            Image(.yLogo)
                                .renderingMode(.template)
                            Text(Spec.yPayText)
                        }
                    } else {
                        Text(card.label)
                    }
                }
                .font(.system(size: Spec.balanceLabelFontSize))
                .foregroundColor(.secondary)
                
                Spacer()
                
                if card.hasTooltip {
                    Image(.tooltip)
                        .renderingMode(.template)
                } else if card.hasChevron {
                    Image(.chevron)
                        .renderingMode(.template)
                }
            }
        }
    }
}

// MARK: - Menu Section View
struct MenuSectionView: View {
    let section: MenuSection
    @Binding var showingWardrobe: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spec.menuDividerSpacing) {
            Text(section.title)
                .sectionHeader()
            
            VStack(spacing: Spec.menuDividerSpacing) {
                ForEach(Array(section.items.enumerated()), id: \.element.id) { index, item in
                    MenuRowView(
                        item: item,
                        showingWardrobe: $showingWardrobe
                    )
                    
                    if index < section.items.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}

// MARK: - Menu Row View
struct MenuRowView: View {
    let item: MenuItem
    @Binding var showingWardrobe: Bool
    @State private var opacity: Double = 1.0
    
    var body: some View {
        Group {
            if item.title == Spec.boughtItemsTitle {
                NavigationLink(destination: BoughtItemsView()) {
                    menuRowContent
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                menuRowContent
                    .onTapGesture {
                        if item.title == Spec.wardrobeTitle {
                            withAnimation(.easeInOut(duration: Spec.tapAnimationDuration)) {
                                opacity = Spec.tapOpacity
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + Spec.tapAnimationDuration) {
                                withAnimation(.easeInOut(duration: Spec.tapAnimationDuration)) {
                                    opacity = 1.0
                                }
                                AnalyticsService.reportEvent(
                                    name: "open_wardrobe",
                                    screen: "Profile",
                                    item: "wardrobe"
                                )
                                showingWardrobe = true
                            }
                        }
                    }
            }
        }
    }
    
    private var menuRowContent: some View {
        HStack(spacing: Spec.menuRowSpacing) {
            Image(item.icon)
                .renderingMode(.template)
            
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.system(size: Spec.titleFontSize, weight: .medium))
                
                if let subtitle = item.subtitle {
                    Text(subtitle)
                        .font(.system(size: Spec.subtitleFontSize))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            HStack(spacing: Spec.menuBadgeSpacing) {
                if let trailingIcon = item.trailingIcon {
                    Image(trailingIcon)
                }
                
                if let badge = item.badge {
                    Text(badge)
                        .badge()
                }
            }
        }
        .padding(.vertical, Spec.menuRowPadding)
        .opacity(item.title == Spec.boughtItemsTitle || item.title == Spec.wardrobeTitle ? opacity : 1.0)
        .contentShape(Rectangle())
    }
}

struct BoughtItemsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.popupCoordinator) private var popupCoordinator
    @State private var shouldNavigateToWardrobe = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image(.boughtChips)
                    .padding(.leading, 82)
                Image(.boughtCards)
                Image(.boughtCards)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Купленные товары")
                    .font(.custom("YS Text Medium", size: 16))
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "magnifyingglass")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .background(
            NavigationLink(
                destination: WardrobeView(),
                isActive: $shouldNavigateToWardrobe
            ) { EmptyView() }
        )
        .onAppear {
            popupCoordinator.show(
                WardrobePopupView(onWardrobeButtonTap: {
                    popupCoordinator.hide()
                    shouldNavigateToWardrobe = true
                })
            )
        }
    }
}

private enum Spec {
    
    // Text Constants
    static let profileName = "Мария Шаkалова"
    static let openProfileText = "Открыть профиль"
    static let cardText = "Карта"
    static let yPayText = "Пэй"
    static let boughtItemsTitle = "Купленные товары"
    static let wardrobeTitle = "Мой гардероб"
    static let chevronRightIcon = "chevron.right"
    
    // Spacing
    static let cardTextSpacing: CGFloat = 2
    
    // Profile Section
    static let profilePhotoSize: CGFloat = 40
    static let profileNameFontSize: CGFloat = 16
    static let profileSubtitleFontSize: CGFloat = 13
    static let profileChevronSize: CGFloat = 12
    static let profileIconSpacing: CGFloat = 16
    static let profileSpacing: CGFloat = 8
    
    // Balance Section
    static let balanceCardSpacing: CGFloat = 26
    static let balanceCardPadding: CGFloat = 16
    static let balanceAmountFontSize: CGFloat = 16
    static let balanceLabelFontSize: CGFloat = 13
    static let balanceIconSpacing: CGFloat = 8
    static let balanceLabelSpacing: CGFloat = 4
    static let balanceTopPadding: CGFloat = 10
    
    // Menu Section
    static let menuSectionSpacing: CGFloat = 16
    static let menuSectionTopPadding: CGFloat = 28
    static let menuRowSpacing: CGFloat = 12
    static let menuRowPadding: CGFloat = 6
    static let menuDividerSpacing: CGFloat = 8
    static let menuBadgeSpacing: CGFloat = 8
    
    // Fonts
    static let titleFontSize: CGFloat = 16
    static let subtitleFontSize: CGFloat = 13
    
    // Animation
    static let tapAnimationDuration: Double = 0.1
    static let tapOpacity: Double = 0.5
}
