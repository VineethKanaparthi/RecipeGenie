//
//  MealDetailViewModel.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/12/23.
//

import SwiftUI
import Combine

class MealDetailViewModel: ObservableObject {
    // MARK: - Published properties
    
    /// A list of meals to store the details of the selected meal.
    @Published var meals: [Meal] = []
    
    /// A flag to indicate whether data is currently being loaded.
    @Published var isLoading = true
    
    /// A flag to indicate whether loading the data has failed.
    @Published var loadFailed = false
    
    // MARK: - Properties
    
    /// The meal associated with this view.
    private let mealId: String
    
    /// the number of retries to fetch meal details
    private var retryCount = 3
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(mealId: String) {
        self.mealId = mealId
    }
    
    // MARK: - API Call
    func fetchMeal(){
        RecipeService.shared.fetchMealDetail(for: mealId){ [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let meals):
                self?.meals = meals
            case .failure:
                self?.loadFailed = true
            }
        }
    }
    
}
