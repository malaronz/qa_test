import XCTest

final class EditProfilePage {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var nameField: XCUIElement {
        return app.textFields[EditProfileLocators.nameField]
    }
    
    var saveButton: XCUIElement {
        return app.buttons[EditProfileLocators.saveButton]
    }
    
    var cancelButton: XCUIElement {
        return app.buttons[EditProfileLocators.cancelButton]
    }
    
    var errorText: XCUIElement {
        return app.staticTexts[EditProfileLocators.errorText]
    }
    
    func enterNewName(_ name: String) {
        nameField.tap()
        nameField.clearAndTypeText(name)
    }
    
    func clearNameField() {
        nameField.tap()
        nameField.clearText()
    }
    
    func tapSaveButton() {
        saveButton.tap()
    }
    
    func tapCancelButton() {
        cancelButton.tap()
    }
}
