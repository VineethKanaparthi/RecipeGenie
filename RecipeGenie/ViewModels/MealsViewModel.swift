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
    
    // MARK: - Properties
    /// the number of retries to fetch meal details
    private var retryCount = 3
    private var cancellables = Set<AnyCancellable>()
    private let mealsURL = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
    
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
        guard let url = mealsURL else {
            self.loadFailed = true
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .print("Network") // debug info
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .retry(retryCount)
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure = completion {
                    self?.loadFailed = true
                }
            }, receiveValue: { [weak self] response in
                self?.meals = response.meals.filter { meal in
                    !(meal.idMeal?.isEmpty ?? true) && !(meal.strMeal?.isEmpty ?? true)
                }
                self?.filterMeals()
            })
            .store(in: &cancellables)
    }
    
    func getFilteredMeals() -> [Meal]{
        return self.filteredMeals
    }
    
    func getMeals() -> [Meal]{
        return self.meals
    }
}

