//
//  ContentView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import SwiftUI

/// A SwiftUI view that displays a list of meals and allows users to search for dessert recipes.
struct ContentView: View {
    
    @StateObject private var mealsViewModel = MealsViewModel()

    // MARK: - Body

    var body: some View {
        NavigationView {
            Group {
                if mealsViewModel.isLoading {
                    ProgressView("Loading...")
                } else if mealsViewModel.loadFailed {
                    VStack {
                        Text("Failed to Load Recipes, please try again later")
                            .foregroundColor(Constants.titleColor)
                            .padding()
                        Button("Retry") {
                            mealsViewModel.fetchMeals()
                        }
                        .padding()
                        .accessibilityLabel("Retry Fetching Recipes")
                    }
                } else {
                    mealList
                }
            }
            .navigationBarTitle("Dessert Recipes")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $mealsViewModel.searchQuery, prompt: "Search recipes")
            .onAppear {
                if mealsViewModel.meals.isEmpty {
                    mealsViewModel.fetchMeals()
                }
            }
        }
    }

    // MARK: - Meal List View

    private var mealList: some View {
        ScrollView {
            if mealsViewModel.filteredMeals.isEmpty {
                Text("No recipes.")
                    .foregroundColor(Constants.titleColor)
                    .padding()
            } else {
                ForEach(mealsViewModel.filteredMeals) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealCardView(meal: meal)
                    }
                }
            }
        }
    }
    
}

// MARK: - Preview

#Preview {
    ContentView()
}
