import SwiftUI

@MainActor
class LookFiltersViewModel: ObservableObject {
    @Published var selectedSeason: String?
    @Published var selectedStyle: String?
    @Published var selectedOccasion: String?
    @Published var isUpdating = false
    private let lookService = LookService()
    var look: Look

    init(look: Look) {
        self.look = look
        selectedStyle = look.style
        selectedSeason = look.season
        selectedOccasion = look.reason
    }
    
    func selectSeason(_ season: String) {
        if selectedSeason == season {
            selectedSeason = nil
        } else {
            selectedSeason = season
        }
    }
    
    func selectStyle(_ style: String) {
        if selectedStyle == style {
            selectedStyle = nil
        } else {
            selectedStyle = style
        }
    }
    
    func selectOccasion(_ occasion: String) {
        if selectedOccasion == occasion {
            selectedOccasion = nil
        } else {
            selectedOccasion = occasion
        }
    }
    @MainActor
    func updateLook() async {
        isUpdating = true
        do {
            let updated = try await lookService.updateLook(
                look: Look(
                    id: look.id,
                    name: look.name,
                    items: look.items,
                    season: selectedSeason,
                    style: selectedStyle,
                    reason: selectedOccasion
                )
            )
            await MainActor.run {
                self.look = Look(
                    id: look.id,
                    name: look.name,
                    items: look.items,
                    season: selectedSeason,
                    style: selectedStyle,
                    reason: selectedOccasion
                )
                self.isUpdating = false
            }
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
                self.isUpdating = false
            }
        }
    }

}

