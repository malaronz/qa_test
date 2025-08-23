import SwiftUI

struct FiltersList: View {
    @Binding var selectedFilter: LocalFilter?
    var type: ClothesType

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                categoryMenu()

                ForEach(LocalFilter.allCases, id: \.title) { filter in
                    filterButton(for: filter)
                }
            }
            .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func categoryMenu() -> some View {
        HStack(spacing: 4) {
            Menu {
                ForEach(availableSubtypes(), id: \.self) { subtype in
                    Button {
                        AnalyticsService.reportEvent(
                            name: "use_filter",
                            screen: "Wardrobe",
                            item: "filter"
                        )
                        selectedFilter = .categories(subtype)
                    } label: {
                        Text(subtype.title)
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(categoryTitle)
                        .font(.custom("YS Text Medium", size: 13))
                        .foregroundColor(isCategorySelected ? .wardrobeWhite : .wardrobeBlack)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(isCategorySelected ? .wardrobeWhite : .wardrobeBlack)
                }
            }

            if isCategorySelected {
                Button(action: {
                    selectedFilter = nil
                }) {
                    Image(.cancel)
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(6)
                }
                .contentShape(Rectangle())
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 9)
        .background(isCategorySelected ? Color.filterOn : Color.chevronBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    @ViewBuilder
    private func filterButton(for filter: LocalFilter) -> some View {
        let isSelected = selectedFilter == filter

        HStack(spacing: 4) {
            Text(filter.title)
                .font(.custom("YS Text Medium", size: 13))
                .foregroundColor(isSelected ? .wardrobeWhite : .wardrobeBlack)
                .padding(.vertical, 9)

            if isSelected {
                Button(action: { selectedFilter = nil }) {
                    Image(.cancel)
                }
            } else {
                Spacer().frame(width: 12)
            }
        }
        .padding(.leading, 12)
        .background(isSelected ? Color.filterOn : Color.chevronBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            AnalyticsService.reportEvent(
                name: "use_filter",
                screen: "Wardrobe",
                item: "filter"
            )
            selectedFilter = filter
        }
    }

    private var isCategorySelected: Bool {
        if case .categories = selectedFilter {
            return true
        }
        return false
    }

    private var categoryTitle: String {
        if case let .categories(subtype) = selectedFilter {
            return subtype.title
        }
        return "Категории"
    }
    private func availableSubtypes() -> [ClothesSubtype] {
        guard type != .none else {
            return ClothesSubtype.allCases.filter { $0 != .none }
        }
        return type.availableSubtypes.filter { $0 != .none }
    }
}

#Preview {
    @State var selectedFilter: LocalFilter? = .bought
    FiltersList(selectedFilter: $selectedFilter, type: .none)
}
