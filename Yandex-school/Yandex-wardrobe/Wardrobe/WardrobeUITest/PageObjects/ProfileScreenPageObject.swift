import XCTest

class ProfileScreenPageObject: BasePageObject {
    
    // MARK: - Screen Validation
    
    func validateScreenLoaded() -> Bool {
        return validateElementExists(locators.myWardrobeButton, message: TestData.Messages.screenNotLoaded)
    }
    
    // MARK: - Navigation Actions
    
    func navigateToWardrobe() -> Bool {
        guard validateScreenLoaded() else { return false }
        
        tapElement(locators.myWardrobeButton)
        wait(seconds: TestData.Constants.navigationDelay)
        
        return true
    }
    
    // MARK: - Element Checks
    
    func isMyWardrobeButtonVisible() -> Bool {
        return locators.myWardrobeButton.exists
    }
    
    func getMyWardrobeButtonText() -> String {
        return locators.myWardrobeButton.label
    }
}
