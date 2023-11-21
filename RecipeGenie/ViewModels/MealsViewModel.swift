//
//  MealsViewModel.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//
import SwiftUI
import Combine

/// A view model for managing meals data and fetching meals from the API.
class MealsViewModel: ObservableObject {
    
    /// The list of meals fetched from the API.
    private var meals: [Meal] = []
    
    /// Meals filtered by search query
    @Published var filteredMeals: [Meal] = []
    
    /// A flag indicating if data is currently being loaded.
    @Published var isLoading = true
    
    /// A flag indicating if loading data has failed.
    @Published var loadFailed = false
    
    /// The search query to filter meals.
    @Published var searchQuery = ""
    
    /// A set to hold references to any cancellable operations so they are not deallocated prematurely.
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init() {
        setupBindings()
    }
    
    // Function to filter meals when the search query changes
    private func filterMeals() {
        self.filteredMeals = self.searchQuery.isEmpty ? self.meals : self.meals.filter {
            $0.strMeal?.lowercased().contains(self.searchQuery.lowercased()) ?? false
        }
    }
    
    // MARK: - Setup
    private func setupBindings() {
        // Whenever the searchQuery changes, filter meals.
        $searchQuery
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main) // Wait for 0.5 seconds after the user stops typing
            .sink { [weak self] searchQuery in
                self?.filterMeals()
            }
            .store(in: &cancellables)
    }
    
    /// Fetches meals from the API.
    // MARK: - API Call
    func fetchMeals() {
        RecipeService.shared.fetchMeals{ [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let meals):
                self?.meals = meals.filter { meal in
                    !(meal.idMeal?.isEmpty ?? true) && !(meal.strMeal?.isEmpty ?? true)
                }
                self?.filterMeals()
            case .failure:
                self?.loadFailed = true
            }
        }
    }
    
    func getFilteredMeals() -> [Meal]{
        return self.filteredMeals
    }
    
    func getMeals() -> [Meal]{
        return self.meals
    }
}

