import SwiftUI

struct WardrobePickerPopupView: View {
    @Environment(\.popupCoordinator) private var popupCoordinator
    @StateObject private var viewModel: WardrobePickerPopupViewModel
    @State private var handleBarHeight: CGFloat = 0
    @State private var headerHeight: CGFloat = 0
    @State private var saveButtonHeight: CGFloat = 0
    @State private var listContentHeight: CGFloat = 0

    init(viewModel: WardrobePickerPopupViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            let availableHeight = max(0, geo.size.height - handleBarHeight - headerHeight - saveButtonHeight - DesignTokens.Spacing.medium - DesignTokens.Constraints.estimatedVerticalPadding)
            VStack(alignment: .leading, spacing: DesignTokens.Spacing.medium) {
                PopupHandleBar()
                    .measureHeight { handleBarHeight = $0 }
                PopupHeader()
                    .measureHeight { headerHeight = $0 }
                profilesList(availableHeight: availableHeight)
                SaveButton(isEnabled: viewModel.canSave) {
                    viewModel.save()
                }
                .measureHeight { saveButtonHeight = $0 }
                Spacer()
            }
            .padding(.horizontal, DesignTokens.Padding.horizontal)
            .padding(.top, DesignTokens.Padding.top)
            .padding(.bottom, DesignTokens.Spacing.medium)
            .background(DesignTokens.Colors.popupBackground)
        }
    }
    
    @ViewBuilder
    private var profilesListContent: some View {
        ForEach(viewModel.profiles) { profile in
            ProfileRowView(
                profile: profile,
                isSelected: viewModel.selectedId == profile.id,
                isEditing: viewModel.editingId == profile.id,
                validationMessage: viewModel.validationMessage,
                shakeToken: viewModel.shakeToken,
                editingText: Binding(
                    get: { viewModel.editingText },
                    set: { viewModel.editingText = $0 }
                ),
                onTap: { viewModel.select(profile.id) },
                onEditTap: { viewModel.startRename(profile.id) },
                onEditingCancel: { viewModel.cancelEditing() }
            )
        }

        if viewModel.profiles.count < viewModel.maxProfiles {
            CreateProfileRowView(
                placeholderEmoji: viewModel.placeholderEmoji,
                isEditing: viewModel.isCreating,
                validationMessage: viewModel.validationMessage,
                shakeToken: viewModel.shakeToken,
                newProfileName: Binding(
                    get: { viewModel.newProfileName },
                    set: { viewModel.newProfileName = $0 }
                ),
                onEditTap: { viewModel.startCreate() },
                onEditingCancel: { viewModel.cancelEditing() }
            )
        }
    }

    private func profilesList(availableHeight: CGFloat) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DesignTokens.Spacing.medium) { 
                profilesListContent 
            }
            .background(
                GeometryReader { geo in
                    Color.clear.preference(key: ViewHeightKey.self, value: geo.size.height)
                }
            )
        }
        .onChange(of: viewModel.profiles.count) { _ in
            listContentHeight = max(listContentHeight, estimatedListHeight())
            if listContentHeight > availableHeight { 
                popupCoordinator.advanceDetent() 
            }
        }
    }
    
    private func estimatedListHeight() -> CGFloat {
        let rowHeight = DesignTokens.ComponentSize.rowHeight
        let spacing = DesignTokens.Spacing.medium
        let itemCount = viewModel.profiles.count + (viewModel.profiles.count < viewModel.maxProfiles ? 1 : 0)
        guard itemCount > 0 else { return 0 }
        
        let totalRowsHeight = CGFloat(itemCount) * rowHeight
        let totalSpacing = CGFloat(max(0, itemCount - 1)) * spacing
        return totalRowsHeight + totalSpacing
    }
}
