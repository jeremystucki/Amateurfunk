import XCTest

class AmateurfunkUITests: XCTestCase {

    func testScreenshotsForAppStore() {
        let app = XCUIApplication()

        setupSnapshot(app)
        app.launch()

        app.tables.staticTexts["Abfragen"].tap()
        app.navigationBars.buttons["star unselected"].tap()

        snapshot("03_Question")

        app.navigationBars.buttons["Technik"].tap()

        snapshot("01_Menu")

        app.navigationBars.buttons["Kapitel wählen"].tap()

        snapshot("02_Chapter")
    }

}
