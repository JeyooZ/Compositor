import XCTest

final class ChineseLocalizationUITests: XCTestCase {
    @MainActor
    func testChineseCanvasFlow() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments += ["-AppleLanguages", "(zh-Hans)", "-AppleLocale", "zh_CN"]
        app.launch()
        let confirm = app.buttons["createCanvas"]
        XCTAssertTrue(confirm.waitForExistence(timeout: 15))
        XCTAssertEqual(confirm.label, "创建画布")
        let dialog = XCTAttachment(screenshot: app.screenshot())
        dialog.name = "Chinese new canvas"
        dialog.lifetime = .keepAlways
        add(dialog)
        confirm.click()
        XCTAssertTrue(app.staticTexts["canvasDimensions"].waitForExistence(timeout: 5))
        let editor = XCTAttachment(screenshot: app.screenshot())
        editor.name = "Chinese editor"
        editor.lifetime = .keepAlways
        add(editor)
    }
}
