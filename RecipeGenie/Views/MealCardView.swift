//
//  MealCardView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

struct MealCardView: View {
    let meal: Meal
    
    var body: some View {
        VStack{
            TitleView(text: meal.strMeal ?? "", textStyle: UIFont.TextStyle.title3, color: Constants.titleColor)
                .padding(.top, 5)
            DessertCardView(url: meal.strMealThumb, imageHeight: 300)
                .padding(.bottom)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Constants.textColor, lineWidth: 2)
        )
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
    }
}
