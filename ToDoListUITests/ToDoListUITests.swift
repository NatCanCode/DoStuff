//
//  ToDoListUITests.swift
//  ToDoListUITests
//
//  Created by N N on 02/03/2023.
//

import XCTest
import CoreData

final class ToDoListUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success": "1"]
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    // Dummy test to test a failed test:
    //    func testDummy() {
    //        XCTFail()
    //    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testNavBarTitle() throws {
        let navBarTitle = app.navigationBars.element
        XCTAssert(navBarTitle.exists)
    }

    func testDateScrollButton() throws {
        let lessThanButton = app.buttons["lessthan"]
        XCTAssert(lessThanButton.exists)
    }

    func testBackgroundImage() throws {
        let backgroundImage = app.images["pink-pattern"]
        XCTAssert(backgroundImage.exists)
    }

    func testAddTaskButton() throws {
        let addTaskButton = app.buttons.element
        XCTAssert(addTaskButton.exists)

        let addTaskButtonLabel = app.buttons["Add New Task"]
        XCTAssertEqual(addTaskButtonLabel.label, "Add New Task")

        let addTaskButtonOpensNewTaskView = app.buttons["Add New Task"].tap()
        let tapped = false
        if tapped {
            XCTAssert(true, "Button was tapped")
        }
    }

    func testSaveButton() throws {
        let saveButton = app.buttons.element
        XCTAssert(saveButton.exists)

        let addTaskButton = app.buttons["Add New Task"].tap()
        let saveButtonIsDisabled = app.buttons["Save button"].tap()
        let tapped = false
        if tapped {
            XCTAssert(true, "Button is disabled")
        }
    }

//    func testSaveTask() throws {
//        try testAddTaskButton()
//        try testTexField()
//        let saveTask = app.buttons["Save button"].tap()
//        let tap = true
//        if tap {
//            XCTAssert(true, "Task is saved")
//        }
//    }

//    func testListCheckmarkButton() throws {
//        let checkmarkButton: Void = app.buttons["Checkmark test"].doubleTap()
//        XCTAssert(checkmarkButton.exists)
//    }

    func testTexField() throws {
        let addTaskButtonOpensNewTaskView = app.buttons["Add New Task"].tap()
        let sectionHeader = app.staticTexts["Section Header"]
        XCTAssert(sectionHeader.exists)

        let taskTextField = app.textFields.firstMatch
        XCTAssert(taskTextField.exists)
        XCTAssertEqual(taskTextField.label, "")

        taskTextField.tap()
        taskTextField.typeText("Feed the cats 🐈🐈🐈‍⬛")
    }

    func testCategoryPicker() throws {
        let OpenNewTaskView = app.buttons["Add New Task"].tap()
        let categoryPicker = app.pickers["Category Picker"]
        //        XCTAssert(categoryPicker.exists)
    }

    func testDAtePicker() throws {
        let OpenOtherTaskView = app.buttons["Add New Task"].tap()
        let datePicker = app.datePickers.element
        XCTAssert(datePicker.exists)
    }

    func testTimeSwitch() throws {
        let OpenAnotherTaskView = app.buttons["Add New Task"].tap()
        let scheduleTimeSwitch = app/*@START_MENU_TOKEN@*/.switches["Schedule Time"]/*[[".cells.switches[\"Schedule Time\"]",".switches[\"Schedule Time\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssert(scheduleTimeSwitch.exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//Finding elements:
//app.alerts.element
//app.buttons.element
//app.collectionViews.element
//app.images.element
//app.maps.element
//app.navigationBars.element
//app.pickers.element
//app.progressIndicators.element
//app.scrollViews.element
//app.segmentedControls.element
//app.staticTexts.element
//app.switches.element
//app.tabBars.element
//app.tables.element
//app.textFields.element
//app.textViews.element
//app.webViews.element
