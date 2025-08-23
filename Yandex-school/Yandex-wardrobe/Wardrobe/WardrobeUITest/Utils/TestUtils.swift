import XCTest

class TestUtils {
    
    // MARK: - Wait Utilities
    static func wait(seconds: TimeInterval) {
        Thread.sleep(forTimeInterval: seconds)
    }
    
    static func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        return element.waitForExistence(timeout: timeout)
    }
    
    // MARK: - Element Finding Utilities
    static func findElementByText(_ app: XCUIApplication, text: String, in elementType: ElementType = .staticText) -> XCUIElement? {
        switch elementType {
        case .staticText:
            let element = app.staticTexts[text]
            return element.exists ? element : nil
        case .button:
            let element = app.buttons[text]
            return element.exists ? element : nil
        case .image:
            let element = app.images[text]
            return element.exists ? element : nil
        case .cell:
            let element = app.cells[text]
            return element.exists ? element : nil
        case .otherElement:
            let element = app.otherElements[text]
            return element.exists ? element : nil
        }
    }
    
    static func findElementContaining(_ app: XCUIApplication, text: String, in elementType: ElementType = .staticText, caseInsensitive: Bool = false) -> XCUIElement? {
        let predicate: NSPredicate
        if caseInsensitive {
            predicate = NSPredicate(format: "label CONTAINS[c] %@", text)
        } else {
            predicate = NSPredicate(format: "label CONTAINS %@", text)
        }
        
        switch elementType {
        case .staticText:
            return app.staticTexts.matching(predicate).firstMatch
        case .button:
            return app.buttons.matching(predicate).firstMatch
        case .image:
            return app.images.matching(predicate).firstMatch
        case .cell:
            return app.cells.matching(predicate).firstMatch
        case .otherElement:
            return app.otherElements.matching(predicate).firstMatch
        }
    }
    
    // MARK: - Element Search Utilities
    static func searchForTextInAllElements(_ app: XCUIApplication, searchText: String) -> Bool {
        let searchMethods: [(String, () -> XCUIElement?)] = [
            ("staticTexts", { app.staticTexts[searchText] }),
            ("buttons", { app.buttons[searchText] }),
            ("images", { app.images[searchText] }),
            ("cells", { app.cells[searchText] }),
            ("otherElements", { app.otherElements[searchText] })
        ]
        
        for (methodName, searchMethod) in searchMethods {
            if let element = searchMethod(), element.exists {
                return true
            }
        }
        
        let containsMethods: [(String, () -> XCUIElement?)] = [
            ("staticTexts contains", { app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", searchText)).firstMatch }),
            ("buttons contains", { app.buttons.matching(NSPredicate(format: "label CONTAINS %@", searchText)).firstMatch }),
            ("images contains", { app.images.matching(NSPredicate(format: "label CONTAINS %@", searchText)).firstMatch }),
            ("cells contains", { app.cells.matching(NSPredicate(format: "label CONTAINS %@", searchText)).firstMatch }),
            ("otherElements contains", { app.otherElements.matching(NSPredicate(format: "label CONTAINS %@", searchText)).firstMatch })
        ]
        
        for (methodName, searchMethod) in containsMethods {
            if let element = searchMethod(), element.exists {
                return true
            }
        }
        
        return false
    }
    
    // MARK: - Screenshot Utilities
    static func takeScreenshot(_ app: XCUIApplication, name: String) {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        XCTContext.runActivity(named: "Taking screenshot: \(name)") { activity in
            activity.add(attachment)
        }
    }
    
    // MARK: - Validation Utilities
    static func validateElementExists(_ element: XCUIElement, message: String) -> Bool {
        if element.exists {
            return true
        } else {
            XCTFail(message)
            return false
        }
    }
    
    static func validateElementNotExists(_ element: XCUIElement, message: String) -> Bool {
        if !element.exists {
            return true
        } else {
            XCTFail(message)
            return false
        }
    }
}

