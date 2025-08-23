import SwiftUI

final class WardrobePickerPopupViewModel: ObservableObject {
    
    @Published var newProfileName: String = ""
    @Published var isCreating: Bool = false
    @Published var editingText: String = ""

    @Published var validationMessage: String? = nil
    @Published var shakeToken: CGFloat = 0

    @Published var profiles: [Profile]
    @Published var selectedId: UUID?
    @Published var editingId: UUID?
    @Published var placeholderEmoji: String
    
    private let originalSelectedId: UUID?
    private let validator: ProfileValidating
    private let emojiService: EmojiProviding
    
    var onSave: (([Profile], UUID?) -> Void)?

    init(
        profiles: [Profile], 
        selectedId: UUID?,
        validator: ProfileValidating = ProfileValidator(),
        emojiService: EmojiProviding = EmojiService()
    ) {
        self.profiles = profiles
        self.selectedId = selectedId
        self.originalSelectedId = selectedId
        self.validator = validator
        self.emojiService = emojiService
        self.placeholderEmoji = emojiService.randomEmoji()
    }

    var hasSelectionChanged: Bool { selectedId != originalSelectedId }
    var maxProfiles: Int { DesignTokens.Constraints.maxProfiles }
    
    var canSave: Bool {
        if editingId != nil { return true }
        if isCreating && !newProfileName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { return true }
        return hasSelectionChanged
    }
    
    func startRename(_ id: UUID) {
        editingId = id
        if let profile = profiles.first(where: { $0.id == id }) {
            editingText = profile.name
        }
    }

    func startCreate() {
        editingId = nil
        newProfileName = ""
        isCreating = true
        placeholderEmoji = emojiService.randomEmoji()
    }

    func cancelEditing() {
        editingId = nil
        validationMessage = nil
        newProfileName = ""
        editingText = ""
        isCreating = false
    }

    func select(_ id: UUID) {
        selectedId = id
    }

    private func validateName(_ name: String, excludingId: UUID? = nil) -> ProfileValidationResult {
        return validator.validate(name: name, excludingId: excludingId, existingProfiles: profiles)
    }

    func save() {
        if let id = editingId { 
            // Handle rename
            let validationResult = validateName(editingText, excludingId: id)
            guard validationResult.isValid else {
                return failValidation(validationResult.errorMessage!)
            }
            
            if let index = profiles.firstIndex(where: { $0.id == id }) {
                profiles[index].name = editingText.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            cancelEditing()
            onSave?(profiles, selectedId)
            return
        }

        guard isCreating, profiles.count < maxProfiles else {
            if hasSelectionChanged { onSave?(profiles, selectedId) }
            return
        }
        
        // Handle create new profile
        let validationResult = validateName(newProfileName)
        guard validationResult.isValid else {
            return failValidation(validationResult.errorMessage!)
        }
        
        let emoji = emojiService.randomEmoji()
        let profile = Profile(
            id: UUID(), 
            name: newProfileName.trimmingCharacters(in: .whitespacesAndNewlines), 
            emoji: emoji
        )
        profiles.append(profile)
        
        cancelEditing()
        onSave?(profiles, selectedId)
    }

    private func failValidation(_ message: String) {
        validationMessage = message
        withAnimation(.default) { shakeToken += 1 }
    }
}
