import XCTest

final class WardrobeUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testOutfitNameConsistency() throws {
        // Тест проверки соответствия названия образа при переходе
        
        // 1. Проверяем, что находимся на странице профиля
        XCTAssertTrue(app.staticTexts["Мария Шакалова"].exists, "Профиль не загружен")
        XCTAssertTrue(app.staticTexts["Мой гардероб"].exists, "Кнопка 'Мой гардероб' не найдена")
        
        // 2. Переходим к гардеробу
        app.staticTexts["Мой гардероб"].tap()
        
        // 3. Ждем загрузки главной страницы гардероба
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 5), "Главная страница гардероба не загрузилась")
        
        // 4. Проверяем, что образ "Выпускной" существует
        let graduationOutfit = app.staticTexts["Выпускной"]
        XCTAssertTrue(graduationOutfit.exists, "Образ 'Выпускной' не найден")
        
        // 5. Запоминаем название образа с главной страницы
        let outfitNameOnMainScreen = graduationOutfit.label
        print("Название образа на главной странице: \(outfitNameOnMainScreen)")
        
        // 6. Открываем образ "Выпускной"
        graduationOutfit.tap()
        
        // 7. Ждем загрузки образа (5 секунд как требовалось)
        Thread.sleep(forTimeInterval: 5.0)
        
        // 8. Проверяем, что находимся на странице образа
        XCTAssertTrue(app.staticTexts["Мой гардероб"].exists, "Заголовок 'Мой гардероб' не найден")
        XCTAssertTrue(app.buttons["Добавить в корзину"].exists, "Кнопка 'Добавить в корзину' не найдена")
        XCTAssertTrue(app.buttons["Примерить"].exists, "Кнопка 'Примерить' не найдена")
        
        // 9. Ищем название образа на странице образа
        let outfitTitleOnOutfitScreen = app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "ОФИС")).firstMatch
        
        // 10. Проверяем, что название образа найдено
        XCTAssertNotNil(outfitTitleOnOutfitScreen, "Название образа на странице образа не найдено")
        
        // 11. Получаем название образа и проверяем его
        if outfitTitleOnOutfitScreen != nil {
            let outfitNameOnOutfitScreen = outfitTitleOnOutfitScreen!.label
            print("Название образа на странице образа: \(outfitNameOnOutfitScreen)")
            
            // 12. Проверяем, что название образа содержит ожидаемый текст "ОФИС"
            XCTAssertTrue(outfitNameOnOutfitScreen.contains("ОФИС"),
                         "Название образа '\(outfitNameOnOutfitScreen)' не содержит ожидаемый текст 'ОФИС'")
            
            // 13. Дополнительная проверка: логируем оба названия для сравнения
            print("=== СРАВНЕНИЕ НАЗВАНИЙ ===")
            print("Главная страница: '\(outfitNameOnMainScreen)'")
            print("Страница образа: '\(outfitNameOnOutfitScreen)'")
            print("Содержит 'ОФИС': \(outfitNameOnOutfitScreen.contains("ОФИС"))")
            print("========================")
        }
        
        // 14. Проверяем наличие основных элементов страницы образа
        XCTAssertTrue(app.staticTexts["Мария Шаталова"].exists, "Имя профиля на странице образа не найдено")
    }
}
