import SwiftUI

struct ItemsScrollView: View {
    let type: ShelfType
    @ObservedObject var viewModel: WardrobeViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                let displayedItems = filteredItems(for: type)
                ForEach(displayedItems, id: \.id) { item in
                    ItemCardView(
                        state: $viewModel.cardsState,
                        isSelected: Binding(
                            get: {
                                viewModel.selectedItems.contains(where: { $0.id == item.id })
                            },
                            set: {_ in
                                viewModel.toggleSelection(for: item)
                            }
                        ),
                        isCarted: Binding(
                            get: {
                                viewModel.cartedItems.contains(where: { $0.id == item.id })
                            },
                            set: { _ in
                                viewModel.toggleCarted(for: item)
                            }
                        ), isBought: viewModel.boughtItems.contains(where: { $0.id == item.id }),
                        item: item,
                        isSkeleton: viewModel.isLoading,
                        onDeleteTapped: {_ in },
                        onMoveTapped: {_ in },
                        onCreateLookTapped: {_ in }
                    )
                    .frame(width: 136, height: 270)
                }
            }
            .padding(.horizontal)
        }
    }

    private func filteredItems(for type: ShelfType) -> [Item] {
        viewModel.displayeditems.filter { item in
            type.clothesType.contains(item.clothesType)
        }
    }
}
