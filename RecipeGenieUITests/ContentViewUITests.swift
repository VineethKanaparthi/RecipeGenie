//
//  ContentViewUITests.swift
//  RecipeGenieUITests
//
//  Created by Vineeth Kanaparthi on 11/8/23.
//

import XCTest
import SwiftUI
@testable import RecipeGenie

class ContentViewTests: XCTestCase {

    func testNavigationTitle() {
        let app = XCUIApplication()
        app.launch()

        let navigationTitle = app.navigationBars["Dessert Recipes"].firstMatch
        XCTAssertTrue(navigationTitle.exists)
    }

    // Add more test cases for fetchMeals and other functionality
}

