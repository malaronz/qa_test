import XCTest

class WardrobeMainScreenPageObject: BasePageObject {
    
    // MARK: - Screen Validation
    
    func validateScreenLoaded() -> Bool {
        return validateElementExists(locators.readyMadeLooksTitle, message: TestData.Messages.screenNotLoaded)
    }
    
    func waitForScreenLoad() -> Bool {
        return waitForScreenLoad(locators.readyMadeLooksTitle)
    }
    
    // MARK: - Outfit Actions
    
    func openOutfit(_ outfit: TestData.Outfit) -> Bool {
        guard validateScreenLoaded() else { return false }
        
        let outfitElement = getOutfitElement(outfit)
        guard outfitElement.exists else {
            XCTFail("Образ '\(outfit.name)' не найден на главной странице")
            return false
        }
        
        tapElement(outfitElement)
        wait(seconds: TestData.Constants.outfitLoadDelay)
        
        return true
    }
    
    func getOutfitElement(_ outfit: TestData.Outfit) -> XCUIElement {
        switch outfit.id {
        case 0:
            return locators.graduationOutfit()
        case 1:
            return locators.officeOutfit()
        case 2:
            return locators.sportOutfit()
        default:
            return locators.graduationOutfit()
        }
    }
    
    // MARK: - Outfit Validation
    
    func validateOutfitExists(_ outfit: TestData.Outfit) -> Bool {
        let outfitElement = getOutfitElement(outfit)
        return validateElementExists(outfitElement, message: "Образ '\(outfit.name)' не найден")
    }
    
    func getOutfitName(_ outfit: TestData.Outfit) -> String {
        let outfitElement = getOutfitElement(outfit)
        return outfitElement.label
    }
    
    // MARK: - Screen Elements
    
    func isReadyMadeLooksTitleVisible() -> Bool {
        return locators.readyMadeLooksTitle.exists
    }
    
    func getReadyMadeLooksTitleText() -> String {
        return locators.readyMadeLooksTitle.label
    }
}
