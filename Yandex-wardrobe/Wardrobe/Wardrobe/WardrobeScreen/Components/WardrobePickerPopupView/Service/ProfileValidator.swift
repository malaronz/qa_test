import Foundation

protocol ProfileValidating {
    func validate(name: String, excludingId: UUID?, existingProfiles: [Profile]) -> ProfileValidationResult
}

enum ProfileValidationResult {
    case valid
    case invalid(String)
    
    var isValid: Bool {
        switch self {
        case .valid: return true
        case .invalid: return false
        }
    }
    
    var errorMessage: String? {
        switch self {
        case .valid: return nil
        case .invalid(let message): return message
        }
    }
}

struct ProfileValidator: ProfileValidating {
    
    func validate(name: String, excludingId: UUID? = nil, existingProfiles: [Profile]) -> ProfileValidationResult {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if empty
        if trimmedName.isEmpty {
            return .invalid(DesignTokens.Text.Validation.emptyName)
        }
        
        // Check length
        if trimmedName.count > DesignTokens.Constraints.maxNameLength {
            return .invalid(DesignTokens.Text.Validation.nameTooLong)
        }
        
        // Check for duplicates
        let isDuplicate = existingProfiles.contains { profile in
            profile.name.caseInsensitiveCompare(trimmedName) == .orderedSame && profile.id != excludingId
        }
        
        if isDuplicate {
            return .invalid(DesignTokens.Text.Validation.nameAlreadyExists)
        }
        
        // Check allowed characters
        let allowedCharacters = CharacterSet.letters.union(.decimalDigits).union(.whitespaces)
        let hasInvalidCharacters = trimmedName.unicodeScalars.contains { !allowedCharacters.contains($0) }
        
        if hasInvalidCharacters {
            return .invalid(DesignTokens.Text.Validation.invalidCharacters)
        }
        
        return .valid
    }
}
