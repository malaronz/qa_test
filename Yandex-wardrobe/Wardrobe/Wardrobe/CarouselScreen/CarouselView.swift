import SwiftUI

struct CarouselView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.tabBarCoordinator) private var tabBarCoordinator
    @StateObject var viewModel: CarouselViewModel
    @State private var isLookCreated = false

    init(viewModel: CarouselViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                clothesSections
                    .padding(.top, 16)
                    .background(.wardrobeWhite)
            }

            if !viewModel.selectedItems.isEmpty {
                saveButton
            }

            NavigationLink(
                destination: viewModel.createdLook.map { look in
                    AnyView(LookView(look: look))
                } ?? AnyView(EmptyView()),
                isActive: Binding(
                    get: { viewModel.createdLook != nil },
                    set: { isActive in
                        if !isActive {
                            viewModel.createdLook = nil
                        }
                    }
                ),
                label: { EmptyView() }
            )
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Выберите товары для образа")
                    .font(.custom("YS Text Medium", size: 16))
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
                Button {
                    AnalyticsService.reportEvent(
                        name: "filter_icon_click",
                        screen: "Carousel",
                        item: "filter_icon"
                    )
                    print("Filter tapped")
                } label: {
                    Image(.filter)
                        .renderingMode(.template)
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .task {
            await viewModel.load()
        }
    }

    private var clothesSections: some View {
        VStack(spacing: 16) {
            ForEach([ClothesType.top, ClothesType.bottom, ClothesType.shoes], id: \.self) { clothesType in
                clothesSection(for: clothesType)
            }
        }
    }

    private func clothesSection(for clothesType: ClothesType) -> some View {
        let items = viewModel.items.filter { $0.clothesType == clothesType }

        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    CarouselItemCard(
                        isSelected:  Binding(
                            get: {
                                viewModel.selectedItems.contains(where: { $0.id == item.id })
                            },
                            set: { newValue in
                                if newValue {
                                    if !viewModel.selectedItems.contains(where: { $0.id == item.id }) {
                                        viewModel.selectedItems.append(item)
                                    }
                                } else {
                                    viewModel.selectedItems.removeAll(where: { $0.id == item.id })
                                }
                            }
                        ),
                        isCarted: false,
                        item: item,
                        isBought: false,
                        checkboxSize: 24,
                        isLoading: viewModel.isLoading
                    )
                    .frame(width: 136, height: 270)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 270)
    }

    private var saveButton: some View {
        Button {
            AnalyticsService.reportEvent(
                name: "save_look_click",
                screen: "Carousel",
                item: "button"
            )
            viewModel.saveLook()
        } label: {
            Text("Сохранить образ")
                .font(.custom("YS Text Medium", size: 16))
                .foregroundColor(.black)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(Color.checkboxOn)
                .cornerRadius(16)
        }
        .padding(16)
        .background(.wardrobeWhite)
    }
}

#Preview {
    CarouselView(
        viewModel: CarouselViewModel(selectedIds: [])
    )
}
