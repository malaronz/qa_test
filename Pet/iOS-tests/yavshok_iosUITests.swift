//
//  yavshok_iosUITests.swift
//  yavshok-iosUITests
//
//  Created by Egor Sheludnev on 22.07.2025.
//

import XCTest

final class ShockTests: XCTestCase {
    @MainActor
    func testValidEmailShowsSuccessState() throws {
        let app = XCUIApplication()
        app.launch()
        let emailCheckPage = EmailCheckPage(app: app)
        emailCheckPage.enterEmailAndCheck("e.sheluddd@gmail.com")
        XCTAssertTrue(emailCheckPage.successText.waitForExistence(timeout: 5), "Текст успеха не появился")
        XCTAssertEqual(emailCheckPage.successText.label, "Ты уже в ШОКе")
        XCTAssertTrue(emailCheckPage.images.count > 0, "На экране нет ни одной картинки (где должна быть гифка)")
    }
    @MainActor
    func testNonexistentEmailShowsFailureState() throws {
        let app = XCUIApplication()
        app.launch()
        let emailCheckPage = EmailCheckPage(app: app)
        let email = EmailGenerator.randomEmail()
        emailCheckPage.enterEmailAndCheck(email)
        XCTAssertTrue(emailCheckPage.failureText.waitForExistence(timeout: 5), "Текст неуспеха не появился")
        XCTAssertEqual(emailCheckPage.failureText.label, "Ты еще не в ШОКе")
    }
    @MainActor
    func testShockButtonRedirectsToLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        XCTAssertTrue(app.staticTexts["Войти в ШОК"].waitForExistence(timeout: 5), "Не перешли на страницу логина")
    }
}
final class LoginTests: XCTestCase {
    @MainActor
    func testLoginWithValidCredentialsShowsProfile() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.login(email: "e.sheluddd@gmail.com", password: "123123")
        defer { loginPage.logoutIfNeeded() }
        XCTAssertTrue(loginPage.photo1.waitForExistence(timeout: 5), "photo_1.jpg не найден на профиле")
        XCTAssertTrue(loginPage.photo2.waitForExistence(timeout: 1), "photo_2.jpg не найден на профиле")
        XCTAssertTrue(loginPage.photo3.waitForExistence(timeout: 1), "photo_3.jpg не найден на профиле")
        XCTAssertTrue(loginPage.photo4.waitForExistence(timeout: 1), "photo_4.jpg не найден на профиле")
    }
    
    @MainActor
    func testLoginWithInvalidCredentialsShowsError() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let email = EmailGenerator.randomEmail()
        let password = PasswordGenerator.randomPassword()
        let loginPage = LoginPage(app: app)
        loginPage.login(email: email, password: password)
        defer { loginPage.logoutIfNeeded() }
        XCTAssertTrue(loginPage.waitForAnyErrorText(timeout: 5), "Текст ошибки не появился")
        let errorText = loginPage.getErrorText()
        XCTAssertNotNil(errorText, "Не удалось получить текст ошибки")
    }
    

    

    
    @MainActor
    func testBackButtonReturnsToMainPage() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapBackButton()
        XCTAssertTrue(app.buttons["navigationButton"].waitForExistence(timeout: 5), "Не вернулись на главную страницу")
    }
    
    @MainActor
    func testRegistrationButtonNavigatesToRegistration() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapRegistrationButton()
        XCTAssertTrue(app.staticTexts["Регистрация в ШОКе"].waitForExistence(timeout: 5), "Не перешли на страницу регистрации")
    }
}

final class RegistrationTests: XCTestCase {
    @MainActor
    func testRegistrationAgeUnder21ShowsYoungCatStatus() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapRegistrationButton()
        
        let registerPage = RegisterPage(app: app)
        let email = EmailGenerator.randomEmail()
        let password = "123123"
        registerPage.register(email: email, password: password, age: "18")
        
        defer { registerPage.logoutIfNeeded() }
        XCTAssertTrue(registerPage.youngCatStatus.waitForExistence(timeout: 10), "Статус 'Ты молоденький котик' не появился")
        XCTAssertEqual(registerPage.youngCatStatus.label, "Ты молоденький котик")
    }
    
    @MainActor
    func testRegistrationAge21To68ShowsAdultCatStatus() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapRegistrationButton()
        
        let registerPage = RegisterPage(app: app)
        let email = EmailGenerator.randomEmail()
        let password = "123123"
        registerPage.register(email: email, password: password, age: "35")
        
        defer { registerPage.logoutIfNeeded() }
        XCTAssertTrue(registerPage.adultCatStatus.waitForExistence(timeout: 10), "Статус 'Ты взрослый котик' не появился")
        XCTAssertEqual(registerPage.adultCatStatus.label, "Ты взрослый котик")
    }
    
    @MainActor
    func testRegistrationAgeOver68ShowsOldCatStatus() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapRegistrationButton()
        
        let registerPage = RegisterPage(app: app)
        let email = EmailGenerator.randomEmail()
        let password = "123123"
        registerPage.register(email: email, password: password, age: "75")
        
        defer { registerPage.logoutIfNeeded() }
        XCTAssertTrue(registerPage.oldCatStatus.waitForExistence(timeout: 10), "Статус 'Ты старый котик' не появился")
        XCTAssertEqual(registerPage.oldCatStatus.label, "Ты старый котик")
    }
    
    @MainActor
    func testBackButtonReturnsToLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Сначала сбрасываем состояние приложения
        Fixtures.resetAppState(app: app)
        
        Fixtures.tapMainShockButton(app: app)
        let loginPage = LoginPage(app: app)
        loginPage.tapRegistrationButton()
        
        let registerPage = RegisterPage(app: app)
        registerPage.tapBackButton()
        XCTAssertTrue(app.staticTexts["Войти в ШОК"].waitForExistence(timeout: 5), "Не вернулись на страницу логина")
    }
}

final class EditProfileTests: XCTestCase {
    @MainActor
    func testEditProfileAndSaveChanges() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Логинимся
        Fixtures.resetAppState(app: app)
        Fixtures.tapMainShockButton(app: app)
        
        let loginPage = LoginPage(app: app)
        loginPage.login(email: "e.sheluddd@gmail.com", password: "123123")
        
        // Переходим в редактирование профиля
        let profilePage = ProfilePage(app: app)
        profilePage.tapEditProfileButton()
        
        // Редактируем имя
        let editProfilePage = EditProfilePage(app: app)
        let newName = "НовоеИмя\(Int.random(in: 1000...9999))"
        editProfilePage.enterNewName(newName)
        editProfilePage.tapSaveButton()
        
        // Проверяем изменения
        XCTAssertTrue(profilePage.profileName.waitForExistence(timeout: 5))
        XCTAssertTrue(profilePage.profileName.label.contains(newName))
    }
    
    @MainActor
    func testEditProfileAndCancelChanges() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Логинимся
        Fixtures.resetAppState(app: app)
        Fixtures.tapMainShockButton(app: app)
        
        let loginPage = LoginPage(app: app)
        loginPage.login(email: "e.sheluddd@gmail.com", password: "123123")
        
        // Получаем исходное имя
        let profilePage = ProfilePage(app: app)
        let originalName = profilePage.profileName.label
        
        // Редактируем и отменяем
        profilePage.tapEditProfileButton()
        let editProfilePage = EditProfilePage(app: app)
        editProfilePage.enterNewName("ВременноеИмя")
        editProfilePage.tapCancelButton()
        
        // Проверяем, что имя не изменилось
        XCTAssertEqual(profilePage.profileName.label, originalName)
    }
    
    @MainActor
    func testEditProfileWithEmptyNameDisablesSaveButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Логинимся
        Fixtures.resetAppState(app: app)
        Fixtures.tapMainShockButton(app: app)
        
        let loginPage = LoginPage(app: app)
        loginPage.login(email: "e.sheluddd@gmail.com", password: "123123")
        
        // Переходим в редактирование
        let profilePage = ProfilePage(app: app)
        profilePage.tapEditProfileButton()
        
        // Очищаем поле имени
        let editProfilePage = EditProfilePage(app: app)
        editProfilePage.clearNameField()
        
        // Проверяем, что кнопка сохранения неактивна
        XCTAssertFalse(editProfilePage.saveButton.isEnabled)
        
        // Дополнительно проверяем, что при попытке нажать на кнопку ничего не происходит
        editProfilePage.saveButton.tap()
        XCTAssertTrue(editProfilePage.saveButton.isEnabled == false)
    }
}
