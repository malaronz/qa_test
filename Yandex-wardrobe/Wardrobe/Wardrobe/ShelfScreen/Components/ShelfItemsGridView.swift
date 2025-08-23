import SwiftUI

struct ShelfItemsGridView: View {
    @ObservedObject var viewModel: ShelfViewModel
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.fixed(179.5), spacing: 16),
                GridItem(.fixed(179.5), spacing: 16)
            ],
            spacing: 16
        ) {
            itemViews
        }
    }

    private var itemViews: some View {
        ForEach(viewModel.displayeditems) { item in
            let isCartedBinding = Binding(
                get: {
                    viewModel.cartedItems.contains(where: { $0.id == item.id })
                },
                set: { _ in
                    viewModel.toggleCarted(for: item)
                }
            )

            let isBought = viewModel.boughtItems.contains(where: { $0.id == item.id })

            DetailedItemCardView(
                item: item,
                isLiked: false,
                isCarted: isCartedBinding,
                isBought: isBought,
                isLoading: viewModel.isLoading
            )
            .frame(width: 179.5, height: 334)
        }
    }
}
