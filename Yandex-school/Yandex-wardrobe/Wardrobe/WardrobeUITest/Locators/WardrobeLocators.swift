import XCTest

class WardrobeLocators: BaseLocator {
    
    // MARK: - Profile Screen Elements
    var myWardrobeButton: XCUIElement {
        return findElement(byText: "Мой гардероб")
    }
    
    // MARK: - Wardrobe Main Screen Elements
    var readyMadeLooksTitle: XCUIElement {
        return findElement(byText: "Готовые образы")
    }
    
    func graduationOutfit() -> XCUIElement {
        return findElement(byText: "Выпускной")
    }
    
    func officeOutfit() -> XCUIElement {
        return findElement(byText: "Офис")
    }
    
    func sportOutfit() -> XCUIElement {
        return findElement(byText: "Спортивная одежда")
    }
    
    // MARK: - Outfit Detail Screen Elements
    var wardrobeTitle: XCUIElement {
        return findElement(byText: "Мой гардероб")
    }
    
    var addToCartButton: XCUIElement {
        return findElement(byText: "Добавить в корзину")
    }
    
    var tryOnButton: XCUIElement {
        return findElement(byText: "Примерить")
    }
    
    var backButton: XCUIElement {
        return findElement(byText: "Назад")
    }
    
    var leftArrowImage: XCUIElement {
        return findElement(byId: "LookArrowLeft", in: .image)
    }
    
    // MARK: - Wait Methods
    func waitForWardrobeMainScreen() -> Bool {
        return waitForElement(readyMadeLooksTitle, timeout: 10)
    }
    
    func waitForOutfitDetailScreen() -> Bool {
        return waitForElement(addToCartButton, timeout: 10)
    }
}
