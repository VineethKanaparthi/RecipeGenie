//
//  MealCardView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

/// A view displaying a meal card with a title and an image.
struct MealCardView: View {
    /// meal associated with this view
    let meal: Meal
    
    var body: some View {
        // MARK: - Title and Image
        VStack{
            TitleView(text: meal.strMeal ?? "", textStyle: UIFont.TextStyle.title3, color: Constants.titleColor)
                .padding(.top, 5)
            DessertImageView(url: meal.strMealThumb, imageHeight: 300)
                .padding(.bottom)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Constants.textColor, lineWidth: 2)
        )
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        // Accessibility label for the entire VStack
        .accessibilityLabel(Text(meal.strMeal ?? "Meal"))
        .accessibility(addTraits: .isButton)
    }
}
