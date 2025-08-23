import XCTest

class BaseLocator {
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - Common Element Finders
    
    func findElement(byText text: String, in elementType: ElementType = .staticText) -> XCUIElement {
        switch elementType {
        case .staticText:
            return app.staticTexts[text]
        case .button:
            return app.buttons[text]
        case .image:
            return app.images[text]
        case .cell:
            return app.cells[text]
        case .otherElement:
            return app.otherElements[text]
        }
    }
    
    func findElement(containing text: String, in elementType: ElementType = .staticText, caseInsensitive: Bool = false) -> XCUIElement? {
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
    
    func findElement(byId identifier: String, in elementType: ElementType = .staticText) -> XCUIElement {
        switch elementType {
        case .staticText:
            return app.staticTexts[identifier]
        case .button:
            return app.buttons[identifier]
        case .image:
            return app.images[identifier]
        case .cell:
            return app.cells[identifier]
        case .otherElement:
            return app.otherElements[identifier]
        }
    }
    
    func waitForElement(_ element: XCUIElement, timeout: TimeInterval = 10) -> Bool {
        return element.waitForExistence(timeout: timeout)
    }
    
    func waitForElement(byText text: String, in elementType: ElementType = .staticText, timeout: TimeInterval = 10) -> Bool {
        let element = findElement(byText: text, in: elementType)
        return waitForElement(element, timeout: timeout)
    }
}

enum ElementType {
    case staticText
    case button
    case image
    case cell
    case otherElement
}
