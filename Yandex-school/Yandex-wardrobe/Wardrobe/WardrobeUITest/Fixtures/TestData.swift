import Foundation

struct TestData {
    
    // MARK: - Outfit Data
    struct Outfit {
        let id: Int
        let name: String
        let expectedElements: [String]
        
        static let graduation = Outfit(
            id: 0,
            name: "Выпускной",
            expectedElements: ["Добавить в корзину", "Примерить", "Мой гардероб"]
        )
        
        static let office = Outfit(
            id: 1,
            name: "Офис",
            expectedElements: ["Добавить в корзину", "Примерить", "Мой гардероб"]
        )
        
        static let sport = Outfit(
            id: 2,
            name: "Спортивная одежда",
            expectedElements: ["Добавить в корзину", "Примерить", "Мой гардероб"]
        )
        
        static let all: [Outfit] = [graduation, office, sport]
    }
    
    // MARK: - Screen Elements
    struct ScreenElements {
        static let profileScreen = [
            "Мой гардероб"
        ]
        
        static let wardrobeMainScreen = [
            "Готовые образы"
        ]
        
        static let outfitDetailScreen = [
            "Добавить в корзину",
            "Примерить",
            "Мой гардероб"
        ]
    }
    
    // MARK: - Test Constants
    struct Constants {
        static let defaultTimeout: TimeInterval = 10.0
        static let outfitLoadDelay: TimeInterval = 5.0
        static let navigationDelay: TimeInterval = 2.0
        
        static let maxRetryAttempts = 3
        static let retryDelay: TimeInterval = 1.0
    }
    
    // MARK: - Test Messages
    struct Messages {
        static let elementNotFound = "Элемент не найден"
        static let screenNotLoaded = "Экран не загрузился"
        static let navigationFailed = "Навигация не удалась"
        static let outfitNotOpened = "Образ не открылся"
        static let titleMismatch = "Название образа не совпадает"
    }
    
    // MARK: - Navigation Paths
    struct NavigationPath {
        static let profileToWardrobe = "Профиль → Гардероб"
        static let wardrobeToOutfit = "Гардероб → Образ"
        static let outfitToWardrobe = "Образ → Гардероб"
    }
    
    // MARK: - Validation Rules
    struct ValidationRules {
        static let caseInsensitive = true
        static let partialMatch = true
        static let exactMatch = false
    }
}
