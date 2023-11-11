//
//  RecipeGenieTests.swift
//  RecipeGenieTests
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import XCTest
@testable import RecipeGenie

final class RecipeGenieTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIngredientAndMeasureAccessors() throws {
        // Given a meal with known ingredients and measures
        let meal = Meal.sampleData.first!

        // When accessing the ingredients and measures
        let ingredient1 = meal.ingredients.first
        let measure1 = meal.measurements.first

        // Then the correct values should be returned
        XCTAssertEqual(ingredient1, "Milk", "The ingredient should be milk.")
        XCTAssertEqual(measure1, "200ml", "The measure should be 200ml.")
    }

    
    

}
