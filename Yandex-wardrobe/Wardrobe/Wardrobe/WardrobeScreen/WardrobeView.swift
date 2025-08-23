import SwiftUI

enum LocalFilter: Equatable {
    case categories(ClothesSubtype)
    case color
    case bought
    case liked
    case carted

    var title: String {
        switch self {
        case .categories:
            return "Категории"
        case .color:
            return "Цвет"
        case .bought:
            return "Купленные"
        case .liked:
            return "Избранные"
        case .carted:
            return "В корзине"
        }
    }

    static var allCases: [LocalFilter] {
        return [.color, .bought, .liked, .carted]
    }
}

struct WardrobeView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.popupCoordinator) private var popupCoordinator
    @StateObject var viewModel: WardrobeViewModel = .init()
    @State private var showCarousel = false

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .wardrobeWhite
        appearance.titleTextAttributes = [.foregroundColor: UIColor.wardrobeBlack]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                if viewModel.isLoading {
                    WardrobeHeaderSkeletonView()
                        .padding(.top, 6)
                } else {
                    WardrobeHeaderView(
                        looks: viewModel.looks,
                        onChevronTap: {

                        },
                        onNewLookTap: {
                            viewModel.cardsState = viewModel.cardsState == .checkBox ? .ellipsis : .checkBox
                        },
                        onLookTap: {_ in }
                    )
                    .padding(.top, 6)
                }
                clothesList
                    .background(.wardrobeWhite)
                    .cornerRadius(24)

            }
            .background(.wardrobeBackground)

            if viewModel.cardsState == .checkBox {
                VStack {
                    Button(action: {
                        AnalyticsService.reportEvent(
                            name: "create_look_click",
                            screen: "Wardrobe",
                            item: "button"
                        )
                        showCarousel = true
                    }) {
                        Text("Создать образ")
                            .font(.custom("YS Text Medium", size: 16))
                            .foregroundColor(.black)
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 18)
                            .background(Color.checkboxOn)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 14)

                    NavigationLink(
                        destination: CarouselView(
                            viewModel: CarouselViewModel(
                                selectedIds: viewModel.selectedItems.map { $0.id }
                            )
                        ),
                        isActive: $showCarousel
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 0) {
                    Text("Мой гардероб")
                        .font(.custom("YS Text Medium", size: 16))
                    Button(action: showPopup) {
                        HStack(alignment: .center, spacing: 0) {
                            Text("Мария Шаталова")
                                .font(.custom("YS Text Regular", size: 13))
                            Image(.moreButton)
                        }
                        .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
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
                    .foregroundStyle(.wardrobeBlack)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .withLoadingAndErrorOverlay(
            isLoading: viewModel.isLoading,
            error: viewModel.error,
            onDismiss: { viewModel.error = nil }
        )
        .task {
            await viewModel.load()
        }
    }

    private var clothesList: some View {
        VStack(spacing: 0) {
            FiltersList(selectedFilter: $viewModel.selectedFilter, type: .none)
                .padding(.top, 16)
                .padding(.bottom, 16)
            ForEach(ShelfType.allCases, id: \.self) { type in
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(type.rawValue)
                            .font(.custom("YS Text Bold", size: 20))
                        Spacer()
                        NavigationLink(destination: ShelfView(type: type)) {
                            HStack {
                                Text("все")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 16)
                    ItemsScrollView(
                        type: type,
                        viewModel: viewModel
                    )
                }
                .padding(.top,10)
                .padding(.bottom,16)
            }
        }
    }

    private func showPopup() {
        let uuid = UUID()

        popupCoordinator.show(
            WardrobePickerPopupView(
                viewModel: WardrobePickerPopupViewModel(
                    profiles: [Profile(
                        id: uuid,
                        name: "Мария Шаталова",
                        emoji: "👩"
                    )],
                    selectedId: uuid
                )
            ),
            config: PopupConfiguration(
                cornerRadius: 20,
                shadowRadius: 24,
                shadowOpacity: 0.12,
                backgroundOpacity: 0.4,
                dismissThreshold: 100,
                velocityThreshold: 500,
                animationConfig: .interpolatingSpring(stiffness: 222, damping: 28),
                detents: [.fraction(0.4), .fraction(0.5)],
                initialDetent: .fraction(0.4)
            )
        )
    }
}

#Preview {
    WardrobeView()
}
