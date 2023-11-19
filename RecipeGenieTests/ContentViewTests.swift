//
//  ContentViewTests.swift
//  RecipeGenieTests
//
//  Created by Vineeth Kanaparthi on 11/8/23.
//

import XCTest
@testable import RecipeGenie

class ContentViewTests: XCTestCase {
    var contentView: MealsView!

    override func setUp() {
        super.setUp()
        contentView = MealsView()
    }

    override func tearDown() {
        contentView = nil
        super.tearDown()
    }

    func testContentViewInitialization() {
        XCTAssertNotNil(contentView)
    }

    // Add more test cases for fetchMeals and other functionality
}

