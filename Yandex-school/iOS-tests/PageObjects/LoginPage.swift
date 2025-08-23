import XCTest

final class LoginPage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var emailField: XCUIElement { app.textFields[LoginLocators.emailField] }
    var passwordField: XCUIElement { app.secureTextFields[LoginLocators.passwordField] }
    var loginButton: XCUIElement { app.buttons[LoginLocators.loginButton] }
    var backButton: XCUIElement { app.buttons[LoginLocators.backButton] }
    var registrationButton: XCUIElement { app.buttons[LoginLocators.registrationButton] }
    var logoutButton: XCUIElement { app.buttons[LoginLocators.logoutButton] }
    var errorText: XCUIElement { app.staticTexts[LoginLocators.errorText] }
    var photo1: XCUIElement { app.images[LoginLocators.photo1] }
    var photo2: XCUIElement { app.images[LoginLocators.photo2] }
    var photo3: XCUIElement { app.images[LoginLocators.photo3] }
    var photo4: XCUIElement { app.images[LoginLocators.photo4] }
    
    // Добавляем разные варианты локаторов для ошибки
    var errorTextAlternative: XCUIElement { app.staticTexts["errorText"] }
    var errorTextLabel: XCUIElement { app.staticTexts["Email или пароль неправильные"] }
    
    func login(email: String, password: String) {
        XCTAssertTrue(emailField.waitForExistence(timeout: 2), "Поле email не найдено на экране входа")
        emailField.tap()
        emailField.typeText(email)
        
        XCTAssertTrue(passwordField.waitForExistence(timeout: 2), "Поле пароля не найдено на экране входа")
        passwordField.tap()
        passwordField.typeText(password)
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2), "Кнопка 'В шок' не найдена на экране входа")
        loginButton.tap()
    }
    
    func loginWithoutPassword(email: String) {
        XCTAssertTrue(emailField.waitForExistence(timeout: 2), "Поле email не найдено на экране входа")
        emailField.tap()
        emailField.typeText(email)
        
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2), "Кнопка 'В шок' не найдена на экране входа")
        loginButton.tap()
    }
    
    func tapBackButton() {
        XCTAssertTrue(backButton.waitForExistence(timeout: 2), "Кнопка 'Назад' не найдена на экране входа")
        backButton.tap()
    }
    
    func tapRegistrationButton() {
        XCTAssertTrue(registrationButton.waitForExistence(timeout: 2), "Кнопка 'Регистрация' не найдена на экране входа")
        registrationButton.tap()
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
    
    // Метод для проверки любого текста ошибки
    func waitForAnyErrorText(timeout: TimeInterval = 5) -> Bool {
        return errorText.waitForExistence(timeout: timeout) ||
               errorTextAlternative.waitForExistence(timeout: 1) ||
               errorTextLabel.waitForExistence(timeout: 1)
    }
    
    // Метод для получения текста ошибки
    func getErrorText() -> String? {
        if errorText.waitForExistence(timeout: 1) {
            return errorText.label
        } else if errorTextAlternative.waitForExistence(timeout: 1) {
            return errorTextAlternative.label
        } else if errorTextLabel.waitForExistence(timeout: 1) {
            return errorTextLabel.label
        }
        return nil
    }
} 