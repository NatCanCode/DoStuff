//
//  ToDoListTests.swift
//  ToDoListTests
//
//  Created by N N on 02/03/2023.
//

import XCTest
import SwiftUI
import CoreData
@testable import ToDoList

final class ToDoListTests: XCTestCase {
    let viewContext = PersistenceController(inMemory: true).container.viewContext

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    @MainActor func testSaveTask() throws {
        let viewModel = ViewModel()

        let id = UUID()
        let createdDate = Date()
        let name = "Do plenty of stuff!"
        let dueDate = Date()
        let scheduleTime = false
        let selectedCategory = Category.leisure // "Leisure 🌿"

        viewModel.saveTask(id: id, createdDate: createdDate, name: name, dueDate: dueDate, scheduleTime: scheduleTime, selectedCategory: Category(rawValue: selectedCategory.rawValue) ?? .leisure)

        XCTAssertEqual(viewModel.taskItems.count, 2)
    }

//    @MainActor func testSaveTaskElements() throws {
//        @ObservedObject var viewModel = ViewModel()
//
//        var task = viewModel.saveTask(id: id, createdDate: createdDate, name: name, dueDate: dueDate, scheduleTime: scheduleTime, selectedCategory: Category(rawValue: selectedCategory.rawValue) ?? .leisure)
//
//        XCTAssertEqual(viewModel.task.name, name)
//        XCTAssertEqual(viewModel.task.createdDate, createdDate)
//        XCTAssertEqual(viewModel.task.dueDate, dueDate)
//        XCTAssertEqual(viewModel.task.scheduleTime, scheduleTime)
//        XCTAssertEqual(viewModel.task.category, category.rawValue)
//    }

    //    extension XCUIElement {
    //        func forceTap() {
    //            if (isHittable) {
    //                tap()
    //            } else {
    //                coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0)).tap()
    //            }
    //        }
    //    }

    func testDateScroll() throws {
        let dateScroll = ViewModel.self
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
