//
//  MealResponse.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import Foundation

struct MealResponse: Decodable {
    let meals: [Meal]
}
