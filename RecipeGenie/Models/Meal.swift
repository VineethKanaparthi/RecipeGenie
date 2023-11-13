//
//  Meal.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import SwiftUI

/// A struct representing a meal with its details.
struct Meal : Identifiable, Codable, Equatable {
    
    // MARK: - Properties
    
    let idMeal: String?
    let strMeal: String?
    let strDrinkAlternate: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: Date?
    
    // MARK: - Computed Properties
    
    var id: String {
        return idMeal!
    }

    var ingredients: [String] {
        return [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20,
        ].compactMap { $0 }
    }

    var measurements: [String] {
        return [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20,
        ].compactMap { $0 }
    }

    // MARK: - Sample Data
    static let sampleData: [Meal] =
    [
        Meal(idMeal: "53049",
             strMeal: "Apam balik",
             strDrinkAlternate: nil,
             strCategory: "Dessert",
             strArea: "Malaysian",
             strInstructions: "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.",
             strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
             strTags: nil,
             strYoutube: "https://www.youtube.com/watch?v=6R8ffRRJcrg",
             strIngredient1: "Milk",
             strIngredient2: "Oil",
             strIngredient3: "Eggs",
             strIngredient4: "Flour",
             strIngredient5: "Baking Powder",
             strIngredient6: "Salt",
             strIngredient7: "Unsalted Butter",
             strIngredient8: "Sugar",
             strIngredient9: "Peanut Butter",
             strIngredient10: "",
             strIngredient11: "",
             strIngredient12: "",
             strIngredient13: "",
             strIngredient14: "",
             strIngredient15: "",
             strIngredient16: "",
             strIngredient17: "",
             strIngredient18: "",
             strIngredient19: "",
             strIngredient20: "",
             strMeasure1: "200ml",
             strMeasure2: "60ml",
             strMeasure3: "2",
             strMeasure4: "1600g",
             strMeasure5: "3 tsp",
             strMeasure6: "1/2 tsp",
             strMeasure7: "25g",
             strMeasure8: "45g",
             strMeasure9: "3 tbs",
             strMeasure10: " ",
             strMeasure11: " ",
             strMeasure12: " ",
             strMeasure13: " ",
             strMeasure14: " ",
             strMeasure15: " ",
             strMeasure16: " ",
             strMeasure17: " ",
             strMeasure18: " ",
             strMeasure19: " ",
             strMeasure20: " ",
             strSource: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
             strImageSource: nil,
             strCreativeCommonsConfirmed: nil,
             dateModified: nil)
    ]
    
    // MARK: - Methods
        
    /// Get a dictionary of ingredients and their respective measures.
    func getIngredientsAndMeasures() -> [String: String] {
        var ingredientsAndMeasures = [String: String]()
        
        for index in 0..<ingredients.count {
            let ingredient = ingredients[index]
            let measure = index < measurements.count ? measurements[index] : ""
            
            if !ingredient.isEmpty && !measure.isEmpty {
                ingredientsAndMeasures[ingredient] = measure
            }
        }
        return ingredientsAndMeasures
    }
    
    /// Format the instructions text for better readability.
    func formatInstructions() -> [String] {
        guard let instructions = strInstructions, !instructions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }

        let formattedInstructions = instructions.replacingOccurrences(of: ".\r\n", with: ". ")
            .replacingOccurrences(of: ". ", with: ".\n")
            .replacingOccurrences(of: "\r", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
        print(formattedInstructions)
        return formattedInstructions
    }

}

