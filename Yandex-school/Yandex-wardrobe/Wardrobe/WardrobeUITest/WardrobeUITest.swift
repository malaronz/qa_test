import XCTest

final class WardrobeUITest: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testGraduationOutfit() throws {
        let outfitName = "Выпускной"
        let myWardrobeButton = app.staticTexts["Мой гардероб"]
        
        XCTAssertTrue(myWardrobeButton.waitForExistence(timeout: 10), "Кнопка 'Мой гардероб' не найдена")
        myWardrobeButton.tap()
        
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 10), "Главная страница гардероба не загрузилась")
        
        let outfit = app.staticTexts[outfitName]
        XCTAssertTrue(outfit.exists, "Образ '\(outfitName)' не найден на главной странице")
        outfit.tap()
        
        Thread.sleep(forTimeInterval: 8.0)
        
        let wardrobeTitle = app.staticTexts["Мой гардероб"]
        XCTAssertTrue(wardrobeTitle.exists, "Заголовок 'Мой гардероб' не найден")
        
        let outfitTitleFound = searchForTextInAllElements(searchText: outfitName)
        
        if !outfitTitleFound {
            let officeButton = app.buttons["ОФИС"]
            if officeButton.exists {
                XCTFail("БАГ: Нажали на '\(outfitName)', но открылся образ 'ОФИС'. Это неправильно!")
                return
            }
        }
        
        XCTAssertTrue(outfitTitleFound, "Название образа '\(outfitName)' на странице образа не найдено")
        
        let backButton = app.buttons["LookArrowLeft"]
        if backButton.exists {
            backButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
        }
    }
    
    func testOfficeOutfit() throws {
        let outfitName = "Офис"
        let myWardrobeButton = app.staticTexts["Мой гардероб"]
        
        XCTAssertTrue(myWardrobeButton.waitForExistence(timeout: 10), "Кнопка 'Мой гардероб' не найдена")
        myWardrobeButton.tap()
        
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 10), "Главная страница гардероба не загрузилась")
        
        let outfit = app.staticTexts[outfitName]
        XCTAssertTrue(outfit.exists, "Образ '\(outfitName)' не найден на главной странице")
        outfit.tap()
        
        Thread.sleep(forTimeInterval: 8.0)
        
        let wardrobeTitle = app.staticTexts["Мой гардероб"]
        XCTAssertTrue(wardrobeTitle.exists, "Заголовок 'Мой гардероб' не найден")
        
        let outfitTitleFound = searchForTextInAllElements(searchText: outfitName)
        XCTAssertTrue(outfitTitleFound, "Название образа '\(outfitName)' на странице образа не найдено")
        
        let backButton = app.buttons["LookArrowLeft"]
        if backButton.exists {
            backButton.tap()
            Thread.sleep(forTimeInterval: 2.0)
        }
    }
    
    func testAllOutfitsExpanded() throws {
        let myWardrobeButton = app.staticTexts["Мой гардероб"]
        XCTAssertTrue(myWardrobeButton.waitForExistence(timeout: 10), "Кнопка 'Мой гардероб' не найдена")
        myWardrobeButton.tap()
        
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 10), "Главная страница гардероба не загрузилась")
        
        let expectedOutfits = ["Выпускной", "Офис", "Спортивная одежда"]
        var foundOutfits: [String] = []
        
        for outfitName in expectedOutfits {
            let outfit = app.staticTexts[outfitName]
            if outfit.exists {
                foundOutfits.append(outfitName)
            }
        }
        
        XCTAssertEqual(foundOutfits.count, expectedOutfits.count, "Не все образы найдены на главной странице")
        
        let expandButton = findExpandButton()
        XCTAssertTrue(expandButton.exists, "Кнопка разворачивания образов не найдена")
        expandButton.tap()
        
        Thread.sleep(forTimeInterval: 3.0)
        
        for outfitName in expectedOutfits {
            let outfit = app.staticTexts[outfitName]
            XCTAssertTrue(outfit.exists, "Образ '\(outfitName)' не найден на экране всех образов")
        }
    }
    
    func testSwipeTests() throws {
        let myWardrobeButton = app.staticTexts["Мой гардероб"]
        XCTAssertTrue(myWardrobeButton.waitForExistence(timeout: 10), "Кнопка 'Мой гардероб' не найдена")
        myWardrobeButton.tap()
        
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 10), "Главная страница гардероба не загрузилась")
        
        testHorizontalScroll()
        testVerticalScroll()
        testTapGestures()
        testLongPressGestures()
        testSwipeGestures()
    }
    
    func testButtonClickability() throws {
        let myWardrobeButton = app.staticTexts["Мой гардероб"]
        XCTAssertTrue(myWardrobeButton.waitForExistence(timeout: 10), "Кнопка 'Мой гардероб' не найдена")
        myWardrobeButton.tap()
        
        let readyMadeLooks = app.staticTexts["Готовые образы"]
        XCTAssertTrue(readyMadeLooks.waitForExistence(timeout: 10), "Главная страница гардероба не загрузилась")
        
        testNavigationButtons()
        testActionButtons()
        testTabBarButtons()
        testFilterButtons()
    }
    
    func testQuickCheck() throws {
        XCTAssertTrue(true)
    }
    
    private func searchForTextInAllElements(searchText: String) -> Bool {
        let caseInsensitiveMethods: [(String, () -> XCUIElement?)] = [
            ("staticTexts contains[c]", { self.app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] %@", searchText.lowercased())).firstMatch }),
            ("buttons contains[c]", { self.app.buttons.matching(NSPredicate(format: "label CONTAINS[c] %@", searchText.lowercased())).firstMatch }),
            ("images contains[c]", { self.app.images.matching(NSPredicate(format: "label CONTAINS[c] %@", searchText.lowercased())).firstMatch }),
            ("cells contains[c]", { self.app.cells.matching(NSPredicate(format: "label CONTAINS[c] %@", searchText.lowercased())).firstMatch }),
            ("otherElements contains[c]", { self.app.otherElements.matching(NSPredicate(format: "label CONTAINS[c] %@", searchText.lowercased())).firstMatch })
        ]
        
        for (methodName, searchMethod) in caseInsensitiveMethods {
            if let element = searchMethod(), element.exists {
                return true
            }
        }
        
        return false
    }
    
    private func findExpandButton() -> XCUIElement {
        let expandButton = app.buttons[">"]
        if expandButton.exists { return expandButton }
        
        let chevronButton = app.buttons["Chevron"]
        if chevronButton.exists { return chevronButton }
        
        let rightArrowButton = app.buttons.matching(NSPredicate(format: "label CONTAINS %@", ">")).firstMatch
        if rightArrowButton.exists { return rightArrowButton }
        
        let arrowButton = app.buttons.matching(NSPredicate(format: "label CONTAINS %@", "arrow")).firstMatch
        if arrowButton.exists { return arrowButton }
        
        let allButtons = app.buttons.allElementsBoundByIndex
        for (index, element) in allButtons.enumerated() {
            let label = element.label
            if !label.isEmpty {
                print("buttons \(index): '\(label)'")
            }
        }
        
        return app.buttons["nonexistent"]
    }
    
    private func testHorizontalScroll() {
        let firstOutfit = app.staticTexts["Выпускной"]
        if firstOutfit.exists {
            firstOutfit.swipeLeft()
            Thread.sleep(forTimeInterval: 1.0)
        }
    }
    
    private func testVerticalScroll() {
        let allItemsTitle = app.staticTexts["Все вещи"]
        if allItemsTitle.exists {
            app.swipeUp()
            Thread.sleep(forTimeInterval: 1.0)
            app.swipeDown()
            Thread.sleep(forTimeInterval: 1.0)
        }
    }
    
    private func testTapGestures() {
        let graduationOutfit = app.staticTexts["Выпускной"]
        if graduationOutfit.exists {
            graduationOutfit.tap()
            Thread.sleep(forTimeInterval: 3.0)
            
            let wardrobeTitle = app.staticTexts["Мой гардероб"]
            if wardrobeTitle.exists {
                let backButton = app.buttons["LookArrowLeft"]
                if backButton.exists {
                    backButton.tap()
                    Thread.sleep(forTimeInterval: 2.0)
                }
            }
        }
    }
    
    private func testLongPressGestures() {
        let firstItem = app.staticTexts.matching(NSPredicate(format: "label CONTAINS %@", "₽")).firstMatch
        if firstItem.exists {
            firstItem.press(forDuration: 2.0)
            Thread.sleep(forTimeInterval: 1.0)
        }
    }
    
    private func testSwipeGestures() {
        let filtersSection = app.staticTexts["Категории"]
        if filtersSection.exists {
            filtersSection.swipeLeft()
            Thread.sleep(forTimeInterval: 1.0)
            filtersSection.swipeRight()
            Thread.sleep(forTimeInterval: 1.0)
        }
        
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            tabBar.swipeLeft()
            Thread.sleep(forTimeInterval: 1.0)
            tabBar.swipeRight()
            Thread.sleep(forTimeInterval: 1.0)
        }
    }
    
    private func testNavigationButtons() {
        let backButton = app.buttons["LookArrowLeft"]
        if backButton.exists {
            XCTAssertTrue(backButton.isEnabled, "Кнопка назад не активна")
            XCTAssertTrue(backButton.isHittable, "Кнопка назад не кликабельна")
        }
        
        let homeButton = app.buttons["Home"]
        if homeButton.exists {
            XCTAssertTrue(homeButton.isEnabled, "Кнопка домой не активна")
            XCTAssertTrue(homeButton.isHittable, "Кнопка домой не кликабельна")
        }
    }
    
    private func testActionButtons() {
        let createButton = app.buttons["Создать новый образ"]
        if createButton.exists {
            XCTAssertTrue(createButton.isEnabled, "Кнопка создания образа не активна")
            XCTAssertTrue(createButton.isHittable, "Кнопка создания образа не кликабельна")
        }
        
        let filterButton = app.buttons["Filter"]
        if filterButton.exists {
            XCTAssertTrue(filterButton.isEnabled, "Кнопка фильтра не активна")
            XCTAssertTrue(filterButton.isHittable, "Кнопка фильтра не кликабельна")
        }
        
        let searchButton = app.buttons["Search"]
        if searchButton.exists {
            XCTAssertTrue(searchButton.isEnabled, "Кнопка поиска не активна")
            XCTAssertTrue(searchButton.isHittable, "Кнопка поиска не кликабельна")
        }
    }
    
    private func testTabBarButtons() {
        let tabBar = app.tabBars.firstMatch
        if tabBar.exists {
            let homeTab = app.tabBars.buttons["Home"]
            if homeTab.exists {
                XCTAssertTrue(homeTab.isEnabled, "Таб домой не активен")
                XCTAssertTrue(homeTab.isHittable, "Таб домой не кликабелен")
            }
            
            let wardrobeTab = app.tabBars.buttons["Wardrobe"]
            if wardrobeTab.exists {
                XCTAssertTrue(wardrobeTab.isEnabled, "Таб гардероб не активен")
                XCTAssertTrue(wardrobeTab.isHittable, "Таб гардероб не кликабелен")
            }
            
            let profileTab = app.tabBars.buttons["Profile"]
            if profileTab.exists {
                XCTAssertTrue(profileTab.isEnabled, "Таб профиль не активен")
                XCTAssertTrue(profileTab.isHittable, "Таб профиль не кликабелен")
            }
        }
    }
    
    private func testFilterButtons() {
        let categoriesTitle = app.staticTexts["Категории"]
        if categoriesTitle.exists {
            let topButton = app.buttons["top1"]
            if topButton.exists {
                XCTAssertTrue(topButton.isEnabled, "Кнопка категории top1 не активна")
                XCTAssertTrue(topButton.isHittable, "Кнопка категории top1 не кликабельна")
            }
            
            let bottomButton = app.buttons["bottom1"]
            if bottomButton.exists {
                XCTAssertTrue(bottomButton.isEnabled, "Кнопка категории bottom1 не активна")
                XCTAssertTrue(bottomButton.isHittable, "Кнопка категории bottom1 не кликабельна")
            }
            
            let shoesButton = app.buttons["shoes1"]
            if shoesButton.exists {
                XCTAssertTrue(shoesButton.isEnabled, "Кнопка категории shoes1 не активна")
                XCTAssertTrue(shoesButton.isHittable, "Кнопка категории shoes1 не кликабельна")
            }
        }
    }
}
