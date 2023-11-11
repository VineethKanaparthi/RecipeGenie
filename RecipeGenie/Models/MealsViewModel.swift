//
//  MealsViewModel.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//
import SwiftUI

/// A view model for managing meals data and fetching meals from the API.
class MealsViewModel: ObservableObject {
    
    /// The list of meals fetched from the API.
    @Published var meals: [Meal] = []
    
    /// A flag indicating if data is currently being loaded.
    @Published var isLoading = true
    
    /// A flag indicating if loading data has failed.
    @Published var loadFailed = false
    
    /// The search query to filter meals.
    @Published var searchQuery = ""
    
    /// Fetches meals from the API.
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        var retryCount = 3 // Set the number of retries
        
        func fetchData() {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response Status Code: \(httpResponse.statusCode)")
                }
                
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    
                    if retryCount > 0 {
                        // Retry fetching data
                        retryCount -= 1
                        self.fetchMeals()
                    } else {
                        // Show "Failed to Load Recipe" message
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.loadFailed = true
                        }
                    }
                    return
                }
                
                if let data = data {
                    do {
                        
                        let result = try JSONDecoder().decode(MealResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.meals = result.meals.filter { meal in
                                return meal.idMeal != nil && !meal.idMeal!.isEmpty && meal.strMeal != nil && !meal.strMeal!.isEmpty
                            }
                            // Check if self.meals is not empty
                            if !self.meals.isEmpty {
                                self.isLoading = false
                            } else {
                                // Handle the case where self.meals is empty
                                self.isLoading = false
                                self.loadFailed = true
                            }
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.loadFailed = true
                        }
                    }
                }
            }.resume()
        }
        fetchData()
    }
}

