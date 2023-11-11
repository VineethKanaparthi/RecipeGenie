//
//  ContentView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import SwiftUI

/// A SwiftUI view that displays a list of meals and allows users to search for dessert recipes.
struct ContentView: View {
    @ObservedObject private var mealsViewModel = MealsViewModel()
    @State private var selectedMeal: Meal?
    
    // MARK: - Computed Properties
    
    var filteredMeals: [Meal] {
        if mealsViewModel.searchQuery.isEmpty {
            return mealsViewModel.meals
        } else {
            let filteredMeals = mealsViewModel.meals.filter{
                if let strMeal = $0.strMeal {
                    return strMeal.lowercased().contains(mealsViewModel.searchQuery.lowercased())
                } else {
                    return false
                }
            }
            return filteredMeals
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            if mealsViewModel.isLoading {
                ProgressView("Loading...")
                    .onAppear {
                        mealsViewModel.fetchMeals()
                    }
            } else {
                if mealsViewModel.loadFailed  {
                    Text("Failed to Load Recipes, please try again after sometime")
                        .foregroundColor(Constants.titleColor)
                        .padding()
                        .accessibilityLabel("Failed to Load Recipes, please try again after some time")
                } else {
                    ScrollView{
                        if filteredMeals.isEmpty {
                            Text("No recipe details available.")
                                .foregroundColor(Constants.titleColor)
                                .padding()
                                .accessibilityLabel("No recipe details available.")
                        } else {
                            ForEach(filteredMeals) { meal in
                                NavigationLink(destination: MealDetailView(meal: meal)) {
                                    MealCardView(meal: meal)
                                }
                            }
                        }
                    }
                    .navigationBarTitle("Dessert Recipes")
                    .navigationBarTitleDisplayMode(.inline)
                    .searchable(text: $mealsViewModel.searchQuery, prompt: "search recipes")
                }
            }
        }
    }
    
    // MARK: - Public Methods
    
    // Expose selectedMeal for testing purposes
    func getSelectedMeal() -> Meal? {
        return selectedMeal
    }
    
    func getMeals() -> [Meal]{
        return mealsViewModel.meals;
    }
    
}


#Preview {
    ContentView()
}
