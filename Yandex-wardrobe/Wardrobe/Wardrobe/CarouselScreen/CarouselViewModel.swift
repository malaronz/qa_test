import Foundation

@MainActor
final class CarouselViewModel: ObservableObject {
    
    @Published private(set) var items: [Item] = []
    @Published var selectedItems: [Item] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    @Published var createdLook: Look? = nil

    private let lookService = LookService()
    private var selectedIds: [Int]

    init(selectedIds: [Int]) {
        self.selectedIds = selectedIds
    }
    
    func load() async {
        await MainActor.run {
            isLoading = true
            error = nil
            items = Item.skeletons
        }
        defer { isLoading = false }
        
        await fetchItems()
    }
    
    func toggleSelection(for item: Item) {
        if let index = selectedItems.firstIndex(where: { $0.id == item.id }) {
            selectedItems.remove(at: index)
        } else {
            selectedItems.append(item)
        }
        print("Selected items: \(selectedItems.count)")
    }

    func saveLook() {
        Task {
            do {
                let look = try await lookService.createLook(
                    look: Look(id: -1, name: "Новый образ", items: selectedItems)
                )
                await MainActor.run {
                    self.createdLook = look
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                    self.error = "Не удалось создать образ: \(error.localizedDescription)"
                }
            }
        }
    }

    private func fetchItems() async {
        do {
            let allItems = try await lookService.lookBuilder(items: selectedIds,filter: Filter(top: nil, bottom: nil, shoes: nil, all: nil, look: nil))
            await MainActor.run {
                self.items = allItems.flatMap({$0})
                self.selectedItems = items.filter({$0.state.contains(.chosen) || selectedIds.contains($0.id)})
                self.isLoading = false
                self.error = nil
            }
        } catch {
            await MainActor.run {
                handleError(error, context: "CarouselViewModel.fetchItems")
            }
        }
    }
    
    private func handleError(_ error: Error, context: String) {
        print("Error in \(context): \(error)")
        self.error = error.localizedDescription
    }
}
