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
    
    init(meal: Meal) {
        _viewModel = StateObject(wrappedValue: MealDetailViewModel(meal: meal))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .onAppear {
                        viewModel.fetchMeal()
                    }
            } else if viewModel.loadFailed {
                Text("Failed to Load Recipe, please try again after some time")
                    .foregroundColor(Color.red)
                    .padding()
            } else {
                // Render the meal details
                VStack(alignment: .leading) {
                    if let detailedMeal = viewModel.meals.first, let _ = detailedMeal.strMeal {
                        // MARK: - Title
                        TitleView(text: detailedMeal.strMeal ?? "", textStyle: .title2, color: Constants.titleColor)
                        Divider()
                        
                        // MARK: - Content
                        DessertImageView(url: detailedMeal.strMealThumb, imageHeight: 300)
                        YouTubeLinkView(youtubeLink: detailedMeal.strYoutube)
                        IngredientsListView(ingredientsAndMeasures: detailedMeal.getIngredientsAndMeasures())
                        InstructionsView(instructionsTexts: detailedMeal.formatInstructions())
                    }
                }
            }
        }
        .accessibilityLabel("Meal Details")
    }
}
