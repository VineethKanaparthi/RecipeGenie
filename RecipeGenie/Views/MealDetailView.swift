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
    @StateObject var viewModel: MealDetailViewModel
    
    // MARK: -Initializer
    init(mealId: String) {
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(mealId: mealId))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...").onAppear{ viewModel.fetchMeal() }
            } else if viewModel.loadFailed {
                Text("Failed to Load Recipe, please try again after some time")
                    .foregroundColor(Color.red)
                    .padding()
            } else {
                // Render the meal details
                VStack(alignment: .leading) {
                    if let meal = viewModel.meals.first, let dessertName = meal.strMeal {
                        TitleView(text: dessertName, textStyle: .title2, color: Constants.titleColor)
                        Divider()
                        DessertImageView(url: meal.strMealThumb, imageHeight: 300)
                        YouTubeLinkView(youtubeLink: meal.strYoutube)
                        IngredientsListView(ingredientsAndMeasures: meal.ingredientsAndMeasures)
                        InstructionsView(instructionsTexts: meal.formattedInstructions)
                    }
                }
            }
        }
        .accessibilityLabel("Meal Details")
    }
}
