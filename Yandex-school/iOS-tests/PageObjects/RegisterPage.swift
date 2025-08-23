import XCTest

final class RegisterPage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var emailField: XCUIElement { app.textFields[RegisterLocators.emailField] }
    var passwordField: XCUIElement { app.secureTextFields[RegisterLocators.passwordField] }
    var ageField: XCUIElement { app.textFields[RegisterLocators.ageField] }
    var registerButton: XCUIElement { app.buttons[RegisterLocators.registerButton] }
    var backButton: XCUIElement { app.buttons[RegisterLocators.backButton] }
    var logoutButton: XCUIElement { app.buttons[RegisterLocators.logoutButton] }
    var youngCatStatus: XCUIElement { app.staticTexts[RegisterLocators.youngCatStatus] }
    var adultCatStatus: XCUIElement { app.staticTexts[RegisterLocators.adultCatStatus] }
    var oldCatStatus: XCUIElement { app.staticTexts[RegisterLocators.oldCatStatus] }
    
    func register(email: String, password: String, age: String) {
        XCTAssertTrue(emailField.waitForExistence(timeout: 2), "Поле email не найдено на экране регистрации")
        emailField.tap()
        emailField.typeText(email)
        
        XCTAssertTrue(passwordField.waitForExistence(timeout: 2), "Поле пароля не найдено на экране регистрации")
        passwordField.tap()
        passwordField.clearText()
        passwordField.typeText(password)
        
        XCTAssertTrue(ageField.waitForExistence(timeout: 2), "Поле возраста не найдено на экране регистрации")
        ageField.tap()
        ageField.typeText(age)
        
        XCTAssertTrue(registerButton.waitForExistence(timeout: 2), "Кнопка 'Зарегистрироваться' не найдена на экране регистрации")
        registerButton.tap()
    }
    
    func tapBackButton() {
        XCTAssertTrue(backButton.waitForExistence(timeout: 2), "Кнопка 'Назад' не найдена на экране регистрации")
        backButton.tap()
    }
    
    func logoutIfNeeded() {
        if logoutButton.waitForExistence(timeout: 2) {
            // Проверяем, можно ли нажать на кнопку
            if logoutButton.isHittable {
                logoutButton.tap()
            } else {
                // Если кнопка не видна, попробуем прокрутить к ней
                app.swipeUp()
                if logoutButton.waitForExistence(timeout: 1) && logoutButton.isHittable {
                    logoutButton.tap()
                }
            }
        }
    }
} 