import XCTest

import XCTest

struct Fixtures {
    static func resetAppState(app: XCUIApplication) {
        // Проверяем, не находимся ли мы уже на странице профиля
        let logoutButton = app.buttons["logoutButton"]
        if logoutButton.waitForExistence(timeout: 2) {
            // Если мы на странице профиля, пытаемся выйти из аккаунта
            // Используем более надежный способ - сначала проверяем, видима ли кнопка
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
    
    static func tapMainShockButton(app: XCUIApplication) {
        // Сначала сбрасываем состояние приложения
        resetAppState(app: app)
        
        // Теперь ищем кнопку "В шок" на главной странице
        let shockButton = app.buttons["navigationButton"]
        XCTAssertTrue(shockButton.waitForExistence(timeout: 2), "Кнопка 'В шок' не найдена на главном экране")
        shockButton.tap()
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear text from a non-string value")
            return
        }
        
        tap()
        
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
    
    func clearAndTypeText(_ text: String) {
        clearText()
        typeText(text)
    }
}
