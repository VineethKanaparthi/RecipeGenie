//
//  MealsViewModel.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//
import SwiftUI

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = true
    @Published var loadFailed = false
    @Published var searchQuery = ""
    
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        var retryCount = 3 // Set the number of retries
        
        func fetchData() {
            URLSession.shared.dataTask(with: url) { data, response, error in
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
                //            if let error = error {
                //                            print("Error: \(error.localizedDescription)")
                //                            return
                //                        }
                
                //            if let httpResponse = response as? HTTPURLResponse {
                //                print("Response Status Code: \(httpResponse.statusCode)")
                //            }
                
                //            if let responseData = data {
                //                            // Process responseData as needed
                //                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "")")
                //            }
                
                if let data = data {
                    do {
                        
                        let result = try JSONDecoder().decode(MealResponse.self, from: data)
                        DispatchQueue.main.async {
                            self.meals = result.meals
                            self.isLoading = false
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

