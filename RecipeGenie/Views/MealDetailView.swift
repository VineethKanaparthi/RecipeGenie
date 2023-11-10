//
//  MealDetailView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//

import SwiftUI

/// A view for displaying details of a meal.
struct MealDetailView: View {
    
    // MARK: - Properties
    
    /// The meal associated with this view.
    let meal: Meal
    
    // MARK: - State
    
    /// A list of meals to store the details of the selected meal.
    @State private var meals: [Meal] = []
    
    /// A flag to indicate whether data is currently being loaded.
    @State private var isLoading = true
    
    /// A flag to indicate whether loading the data has failed.
    @State private var loadFailed = false
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .onAppear {
                        fetchMeal()
                    }
            } else {
                if loadFailed {
                    Text("Failed to Load Recipe, please try again after some time")
                        .foregroundColor(Color.red)
                        .padding()
                } else {
                    
                    // MARK: - Title
                    
                    TitleView(text: "Recipe Details", textStyle: .title1, color: Constants.textColor)
                    Spacer()
                    
                    // MARK: - Content
                    
                    VStack(alignment: .leading) {
                        if let detailedMeal = meals.first, let _ = detailedMeal.strMeal {
                            TitleView(text: meal.strMeal ?? "", textStyle: .title2, color: Constants.titleColor)
                            Divider()
                            DessertCardView(url: meal.strMealThumb, imageHeight: 300)
                            YouTubeLinkView(youtubeLink: detailedMeal.strYoutube)
                            IngredientsListView(ingredientsAndMeasures: detailedMeal.getIngredientsAndMeasures())
                            InstructionsView(instructionsTexts: detailedMeal.formatInstructions())
                        }
                    }
                }
            }
        }
        .accessibilityLabel("Meal Details")
    }
    
    // MARK: - Methods
    
    /// Fetches details of the selected meal using an API request.
    func fetchMeal() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=" + meal.id) else { return }
        
        var retryCount = 3 // the number of retries
        
        func fetchData() {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    
                    if retryCount > 0 {
                        // Retry fetching data
                        retryCount -= 1
                        fetchMeal()
                    } else {
                        // to show "Failed to Load Recipe" message
                        isLoading = false
                        loadFailed = true
                    }
                    
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response Status Code: \(httpResponse.statusCode)")
                }
                
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(MealResponse.self, from: data)
                        meals = result.meals
                        isLoading = false
                    } catch {
                        print("Error decoding data: \(error)")
                        isLoading = false
                        loadFailed = true
                    }
                }
            }.resume()
        }
        
        fetchData()
    }
}



