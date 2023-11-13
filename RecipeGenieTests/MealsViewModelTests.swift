//
//  MealsViewModelTests.swift
//  RecipeGenieTests
//
//  Created by Vineeth Kanaparthi on 11/13/23.
//

import XCTest
@testable import RecipeGenie

class MealsViewModelTests: XCTestCase {
    var viewModel: MealsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MealsViewModel()
        viewModel.meals = Meal.sampleData
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFilterMealsWithEmptyQuery() throws {
        viewModel.searchQuery = ""
        XCTAssertEqual(viewModel.getFilteredMeals(), viewModel.getMeals())
    }

    func testFilterMealsWithNonEmptyQuery() throws {
        let searchQuery = "Chicken"
        viewModel.searchQuery = searchQuery
        let filtered = viewModel.getMeals().filter { $0.strMeal?.lowercased().contains(searchQuery.lowercased()) ?? false }
        XCTAssertEqual(viewModel.getFilteredMeals(), filtered)
    }

}

