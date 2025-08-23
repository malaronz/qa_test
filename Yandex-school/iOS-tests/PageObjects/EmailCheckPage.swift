import XCTest

final class EmailCheckPage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var emailField: XCUIElement { app.textFields[EmailCheckLocators.emailField] }
    var checkButton: XCUIElement { app.buttons[EmailCheckLocators.checkButton] }
    var successText: XCUIElement { app.staticTexts[EmailCheckLocators.successText] }
    var failureText: XCUIElement { app.staticTexts[EmailCheckLocators.failureText] }
    var images: XCUIElementQuery { app.images }
    
    func enterEmailAndCheck(_ email: String) {
        XCTAssertTrue(emailField.waitForExistence(timeout: 2), "Поле email не найдено")
        emailField.tap()
        emailField.typeText(email)
        
        XCTAssertTrue(checkButton.waitForExistence(timeout: 2), "Кнопка проверки не найдена")
        app.activate()
        app.activate()
        app.activate()
        checkButton.tap()
    }
} 