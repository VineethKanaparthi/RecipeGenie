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
    private let meal: Meal
    
    /// the number of retries to fetch meal details
    private var retryCount = 3
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(meal: Meal) {
        self.meal = meal
    }
    
    // MARK: - API Call
    func fetchMeal() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.id)") else {
            self.loadFailed = true
            self.isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .print("Network") // debug info
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .retry(retryCount)
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure = completion {
                    self.loadFailed = true
                }
            }, receiveValue: { response in
                self.meals = response.meals
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
}
