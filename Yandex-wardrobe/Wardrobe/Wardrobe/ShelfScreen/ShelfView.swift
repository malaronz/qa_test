import SwiftUI

struct ShelfView: View {
    @Environment(\.dismiss) private var dismiss
    var type: ShelfType
    @StateObject var viewModel: ShelfViewModel

    init(type: ShelfType) {
        self.type = type
        _viewModel = StateObject(wrappedValue: ShelfViewModel(type: type))
    }

    var body: some View {
        ScrollView {
            Text(type.rawValue)
                .font(.custom("YS Text Bold", size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
            Spacer().frame(height: 0)
            if viewModel.isLoading {
                ClothesSubtypesSkeletonView()
            } else {
                ClothesSubtypesList(
                    shelfType: type,
                    items: viewModel.items,
                    selectedClothesSubtype: $viewModel.selectedClothesSubtype,
                    selectedClothesTypeForAll: $viewModel.selectedClothesTypeForAll
                )
            }
            Spacer().frame(height: 0)
            FiltersList(selectedFilter: $viewModel.selectedFilter, type: type == .all ? .none : type.clothesType[0])
            ShelfItemsGridView(viewModel: viewModel)
            .padding(.horizontal, 16)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 0) {
                    Text("Мой гардероб")
                        .font(.custom("YS Text Medium", size: 16))
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.wardrobeBlack)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "magnifyingglass")
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .withLoadingAndErrorOverlay(
                isLoading: viewModel.isLoading,
                error: viewModel.error,
                onDismiss: { viewModel.error = nil }
            )
        .task {
            await viewModel.load()
        }
    }

}

#Preview {
    ShelfView(type: .top)
}
