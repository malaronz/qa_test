import XCTest

final class ProfilePage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var profileName: XCUIElement {
        return app.staticTexts.matching(NSPredicate(format: "identifier == 'userName'")).firstMatch
    }
    
    var editProfileButton: XCUIElement {
        return app.buttons.matching(NSPredicate(format: "label == 'Редактировать профиль'")).firstMatch
    }
    
    func tapEditProfileButton() {
        XCTAssertTrue(editProfileButton.waitForExistence(timeout: 5), "Кнопка 'Редактировать профиль' не найдена")
        editProfileButton.tap()
    }
}
