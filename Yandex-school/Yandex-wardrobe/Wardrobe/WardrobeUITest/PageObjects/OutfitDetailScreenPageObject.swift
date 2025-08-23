import XCTest

class OutfitDetailScreenPageObject: BasePageObject {
    
    // MARK: - Screen Validation
    
    func validateScreenLoaded() -> Bool {
        let hasWardrobeTitle = validateElementExists(locators.wardrobeTitle, message: "Заголовок 'Мой гардероб' не найден")
        let hasAddToCartButton = validateElementExists(locators.addToCartButton, message: "Кнопка 'Добавить в корзину' не найдена")
        let hasTryOnButton = validateElementExists(locators.tryOnButton, message: "Кнопка 'Примерить' не найдена")
        
        return hasWardrobeTitle && hasAddToCartButton && hasTryOnButton
    }
    
    func waitForScreenLoad() -> Bool {
        return waitForScreenLoad(locators.addToCartButton)
    }
    
    // MARK: - Title Validation
    
    func validateOutfitTitle(outfitName: String) -> Bool {
        return findOutfitTitle(outfitName: outfitName)
    }
    
    func searchForOutfitTitle(outfitName: String) -> Bool {
        return utils.searchForTextInAllElements(app, searchText: outfitName)
    }
    
    // MARK: - Element Checks
    
    func isWardrobeTitleVisible() -> Bool {
        return locators.wardrobeTitle.exists
    }
    
    func isAddToCartButtonVisible() -> Bool {
        return locators.addToCartButton.exists
    }
    
    func isTryOnButtonVisible() -> Bool {
        return locators.tryOnButton.exists
    }
    
    // MARK: - Navigation
    
    func navigateBackToWardrobe() {
        navigateBack()
    }
    
    // MARK: - Screenshot
    
    func takeOutfitDetailScreenshot(outfitName: String) {
        takeScreenshot(name: "OutfitDetail_\(outfitName)")
    }
}

