import Foundation
import Combine

final class WardrobeViewModel: ObservableObject {

    // MARK: - @Published
    @Published var cardsState: ItemCardState = .ellipsis
    private var items: [Item] = []
    @Published private(set) var displayeditems: [Item] = []
    @Published var selectedItems: [Item] = []
    @Published var cartedItems: [Item] = []
    @Published var boughtItems: [Item] = []

    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    @Published var selectedFilter: LocalFilter? {
        didSet {
            switch selectedFilter {
            case .bought:
                displayeditems = items.filter({$0.state.contains(.bought)})
            case .carted:
                displayeditems = items.filter({$0.state.contains(.bucket)})
            case .liked:
                displayeditems = items.filter({$0.state.contains(.liked)})
            case .categories(let subtype):
                displayeditems = items.filter({$0.clothesSubtype == subtype})
            case .color:
                displayeditems = items
            case nil:
                displayeditems = items
            }
        }
    }
    @Published var looks: [Look] = []
    var wasOpened = false

    // MARK: - Private Properties
    private let userService = UserService()

    // MARK: - Public Methods
    func load() async {
        await MainActor.run {
            isLoading = true
            error = nil
            if !wasOpened {
                displayeditems = Item.skeletons
                wasOpened = true
            }
        }

        defer { Task { @MainActor in isLoading = false } }

        await fetchItemsAndLooks()
    }

    func toggleSelection(for item: Item) {
        if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
            selectedItems.remove(at: index)
        } else {
            selectedItems.append(item)
        }
        print("selectedItems: \(selectedItems)")
    }

    func removeFromWardrobe(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }

    func toggleCarted(for item: Item) {
        if let index = cartedItems.firstIndex(where: { $0.id == item.id }) {
            cartedItems.remove(at: index)
        } else {
            AnalyticsService.reportEvent(
                name: "add_to_cart",
                screen: "Wardrobe",
                item: "Item"
            )
            Task {
                do {
                    try await userService.addToCart([item])
                    await MainActor.run {
                        cartedItems.append(item)
                    }
                } catch {
                    handleError(error, context: "WardrobeViewModel.toggleCarted")
                }
            }
        }
    }

    // MARK: - Private Methods

    private func fetchItemsAndLooks() async {
        do {
            let itemsAndLooks = try await userService.startScreen(filter: Filter(top: nil, bottom: nil, shoes: nil, all: nil, look: nil))
            let items = itemsAndLooks.allItems
            let looks = itemsAndLooks.looks
            await MainActor.run {
                self.looks = looks
                self.items = items
                self.displayeditems = items
                self.boughtItems = items.filter({$0.state.contains(.bought)})
                self.cartedItems = items.filter({$0.state.contains(.bucket)})
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
}
