import XCTest

final class ChineseLocalizationUITests: XCTestCase {
    @MainActor
    func testChineseCanvasFlow() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments += ["-AppleLanguages", "(zh-Hans)", "-AppleLocale", "zh_CN"]
        app.launch()
        let about = app.descendants(matching: .any)["communityAbout"]
        print(app.debugDescription)
        XCTAssertTrue(about.waitForExistence(timeout: 15))
        XCTAssertEqual(about.label, "社区中文版 · 站长小庞")
        about.click()
        let aboutWindow = app.windows["关于 Compositor 中文版"]
        XCTAssertTrue(aboutWindow.waitForExistence(timeout: 5))
        XCTAssertTrue(aboutWindow.staticTexts["中文本地化与维护：站长小庞"].exists)
        XCTAssertTrue(aboutWindow.staticTexts["微信：dlzzxp"].exists)
        aboutWindow.buttons["copyWeChat"].click()
        XCTAssertEqual(aboutWindow.buttons["copyWeChat"].label, "已复制")
        let aboutScreenshot = XCTAttachment(screenshot: app.screenshot())
        aboutScreenshot.name = "Chinese about and contact"
        aboutScreenshot.lifetime = .keepAlways
        add(aboutScreenshot)
        aboutWindow.buttons[XCUIIdentifierCloseWindow].click()
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
