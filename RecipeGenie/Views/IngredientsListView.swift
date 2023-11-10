//
//  IngredientsListView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//

import SwiftUI

/// A view for displaying the list of ingredients for a meal.
struct IngredientsListView: View {
    /// Dictionary of ingredients and their corresponding measurements
    let ingredientsAndMeasures: [String: String]?
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            // MARK: - Title
            TitleView(text: "Ingredients: ", textStyle: .title2, color: Constants.titleColor)
                .accessibilityLabel("Ingredients")
            
            Divider()
            if let ingredientsAndMeasures = ingredientsAndMeasures, !ingredientsAndMeasures.isEmpty {
                // MARK: - Ingredients List
                VStack{
                    ForEach(ingredientsAndMeasures.sorted(by: { $0.key < $1.key }), id: \.key) { ingredient, measure in
                        HStack {
                            Text("\(ingredient):")
                                .frame(alignment: .leading)
                                .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                                .foregroundColor(Constants.textColor)
                                .accessibilityLabel("Ingredient: \(ingredient)")
                            
                            Spacer()
                            
                            Text(measure)
                                .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                                .foregroundColor(Constants.textColor)
                                .accessibilityLabel("Measurement: \(measure)")
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }else{
                // MARK: - No Ingredients Message
                Text("No ingredients available for this meal.")
                    .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    .foregroundColor(Constants.textColor)
                    .padding()
                    .accessibilityLabel("No ingredients available")
            }
        }
    }
}
