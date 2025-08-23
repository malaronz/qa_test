import XCTest

class BasePageObject {
    let app: XCUIApplication
    let locators: WardrobeLocators
    let utils: TestUtils.Type
    
    init(app: XCUIApplication) {
        self.app = app
        self.locators = WardrobeLocators(app: app)
        self.utils = TestUtils.self
    }
    
    // MARK: - Common Actions
    
    func wait(seconds: TimeInterval) {
        TestUtils.wait(seconds: seconds)
    }
    
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = TestData.Constants.defaultTimeout) -> Bool {
        return utils.waitForElement(element, timeout: timeout)
    }
    
    func tapElement(_ element: XCUIElement) {
        guard element.exists else {
            XCTFail("Элемент не существует для нажатия")
            return
        }
        element.tap()
    }
    
    func validateElementExists(_ element: XCUIElement, message: String) -> Bool {
        return utils.validateElementExists(element, message: message)
    }
    
    func validateElementNotExists(_ element: XCUIElement, message: String) -> Bool {
        return utils.validateElementNotExists(element, message: message)
    }
    
    // MARK: - Navigation Helpers
    
    func navigateBack() {
        if locators.backButton.exists {
            tapElement(locators.backButton)
        } else if locators.leftArrowImage.exists {
            tapElement(locators.leftArrowImage)
        } else {
            XCTFail("Кнопка возврата не найдена")
        }
        
        wait(seconds: TestData.Constants.navigationDelay)
    }
    
    func waitForScreenLoad(_ element: XCUIElement, timeout: TimeInterval = TestData.Constants.defaultTimeout) -> Bool {
        return waitForElement(element, timeout: timeout)
    }
    
    // MARK: - Screenshot Helpers
    
    func takeScreenshot(name: String) {
        utils.takeScreenshot(app, name: name)
    }
    
    // MARK: - Element Search Helpers
    
    func findOutfitTitle(outfitName: String) -> Bool {
        return utils.searchForTextInAllElements(app, searchText: outfitName)
    }
    
    func findElementByText(_ text: String, in elementType: ElementType = .staticText) -> XCUIElement? {
        return utils.findElementByText(app, text: text, in: elementType)
    }
    
    func findElementContaining(_ text: String, in elementType: ElementType = .staticText, caseInsensitive: Bool = false) -> XCUIElement? {
        return utils.findElementContaining(app, text: text, in: elementType, caseInsensitive: caseInsensitive)
    }
}
