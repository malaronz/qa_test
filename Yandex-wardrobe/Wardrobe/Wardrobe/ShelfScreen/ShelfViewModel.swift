import Foundation
import Combine

enum ShelfType: String, CaseIterable {
    case all = "Все вещи"
    case top = "Верх"
    case bottom = "Низ"
    case shoes = "Обувь"

    var clothesType: [ClothesType] {
        switch self {
        case .top:
            return [.top]
        case .bottom:
            return [.bottom]
        case .shoes:
            return [.shoes]
        case .all:
            return [.top, .bottom, .shoes]
        }
    }
}

final class ShelfViewModel: ObservableObject {
    @Published var selectedFilter: LocalFilter? {
        didSet {
            updateDisplayedItems()
        }
    }
    @Published var selectedClothesSubtype: ClothesSubtype? {
        didSet {
            updateDisplayedItems()
        }
    }
    @Published var selectedClothesTypeForAll: ClothesType? {
        didSet {
            updateDisplayedItems()
        }
    }

    var type: ShelfType
    var items: [Item] = []
    @Published private(set) var displayeditems: [Item] = []
    @Published var cartedItems: [Item] = []
    @Published var boughtItems: [Item] = []
    private var filteredItems: [Item] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil

    // MARK: - Public Methods
    func load() async {
        await MainActor.run {
            isLoading = true
            error = nil
            displayeditems = type == .all ? Item.skeletons : Item.skeletons(for: type.clothesType[0])
        }
        defer { Task { @MainActor in isLoading = false } }

        await fetchItemsAndLooks()
    }

    init(type: ShelfType) {
        self.type = type
    }

    func toggleCarted(for item: Item) {
        if let index = cartedItems.firstIndex(where: { $0.id == item.id }) {
            cartedItems.remove(at: index)
        } else {
            cartedItems.append(item)
        }
    }

    // MARK: - Private Methods

    private func fetchItemsAndLooks() async {
        do {
            let itemsAndLooks = try await UserService().startScreen(filter: Filter(top: nil, bottom: nil, shoes: nil, all: nil, look: nil))
            let items = itemsAndLooks.allItems
            let filtered = items.filter({type.clothesType.contains($0.clothesType)})
            await MainActor.run {
                self.items = filtered
                self.updateDisplayedItems()
                self.boughtItems = filtered.filter({$0.state.contains(.bought)})
                self.cartedItems = filtered.filter({$0.state.contains(.bucket)})
            }
        } catch {
            handleError(error, context: "WardrobeViewModel.fetchUser")
        }
    }

    private func handleError(_ error: Error, context: String) {
        Task { @MainActor in
            var description = ""
            description = (error as? LocalizedError)?.errorDescription ?? "Неизвестная ошибка"
            self.error = description
            print("[\(context)] - Ошибка: \(error)")
        }
    }

    private func updateDisplayedItems() {
        var tempItems: [Item]
        if type == .all {
            if let selectedClothesTypeForAll {
                tempItems = items.filter { $0.clothesType == selectedClothesTypeForAll }
            } else {
                tempItems = items
            }
        } else {
            if let selectedClothesSubtype {
                tempItems = items.filter { $0.clothesSubtype == selectedClothesSubtype }
            } else {
                tempItems = items
            }
        }

        switch selectedFilter {
        case .bought:
            tempItems = tempItems.filter { $0.state.contains(.bought) }
        case .carted:
            tempItems = tempItems.filter { $0.state.contains(.bucket) }
        case .liked:
            tempItems = tempItems.filter { $0.state.contains(.liked) }
        case .categories(let subtype):
            tempItems = tempItems.filter { $0.clothesSubtype == subtype}
        case .color, nil:
            break
        }

        // Обновляем результат
        self.filteredItems = tempItems
        self.displayeditems = tempItems
    }
}

