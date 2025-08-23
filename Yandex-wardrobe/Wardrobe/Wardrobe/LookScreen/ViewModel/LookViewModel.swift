import SwiftUI

extension LookView {
    @MainActor
    class ViewModel: ObservableObject {
        private let lookService = LookService()
        private let userService = UserService()

        @Published var look: Look
        @Published var isLoadingName = false
        @Published var isLoadingItems = false
        @Published var errorMessage: String?

        init(look: Look) {
            self.look = look
        }

        // MARK: - Look Management

        func refreshLook() async {
            //await loadLook()
        }

        // MARK: - Item Management

        func addItemsToCart() {
            AnalyticsService.reportEvent(
                name: "add_to_cart",
                screen: "Look",
                item: "look"
            )
            Task {
                do {
                    try await userService.addToCart(look.items)
                    print("Added items to cart")
                } catch {
                    await MainActor.run {
                        print(error.localizedDescription)
                        self.errorMessage = "Failed to load look: \(error.localizedDescription)"
                        self.isLoadingName = false
                        self.isLoadingItems = false
                    }
                }
            }
        }

        func addItemToCart(_ item: Item) {
            AnalyticsService.reportEvent(
                name: "add_to_cart",
                screen: "Look",
                item: "Item"
            )
            Task {
                do {
                    try await userService.addToCart([item])
                } catch {
                    await MainActor.run {
                        self.errorMessage = "Failed to load look: \(error.localizedDescription)"
                        self.isLoadingName = false
                        self.isLoadingItems = false
                    }
                }
            }
            print("Add to cart: \(item.name)")
        }

        func tryOnItem(_ item: Item) {
            // TODO: Implement try on functionality
            print("Try on: \(item.name)")
        }

        // MARK: - Look Name Update

        @MainActor
        func updateLookName(_ newName: String) async {
            isLoadingName = true
            isLoadingItems = true
            errorMessage = nil
            do {
                let updatedLook = try await lookService.updateLook(
                    look: Look(
                        id: look.id,
                        name: newName,
                        items: look.items,
                        season: look.season,
                        style: look.style,
                        reason: look.reason
                    )
                )

                await MainActor.run {
                    print(updatedLook)
                    self.look = Look(
                        id: look.id,
                        name: newName,
                        items: look.items,
                        season: look.season,
                        style: look.style,
                        reason: look.reason
                    )
                    self.isLoadingName = false
                    self.isLoadingItems = false
                    errorMessage = nil
                }
            } catch {
                await MainActor.run {
                    print(error.localizedDescription)
                    self.errorMessage = "Failed to load look: \(error.localizedDescription)"
                    self.isLoadingName = false
                    self.isLoadingItems = false
                }
            }
        }

        // MARK: - Photo Fitting

        func createPhotoFittingViewModel() -> PhotoFittingViewModel {
            let topItem = look.items.first { $0.clothesType == .top }
            let bottomItem = look.items.first { $0.clothesType == .bottom }
            let shoesItem = look.items.first { $0.clothesType == .shoes }
            
            let clothingURLs = [
                topItem?.photoURL?.absoluteString ?? "",
                bottomItem?.photoURL?.absoluteString ?? "",
                shoesItem?.photoURL?.absoluteString ?? ""
            ]
            
            return PhotoFittingViewModel(clothingURLs: clothingURLs)
        }
    }
}
