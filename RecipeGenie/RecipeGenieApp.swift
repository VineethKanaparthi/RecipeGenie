//
//  RecipeGenieApp.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import SwiftUI

@main
struct RecipeGenieApp: App {
    @StateObject var mealsViewModel = MealsViewModel()
    var body: some Scene {
        WindowGroup {
            MealsView(mealsViewModel: mealsViewModel)
                .font(Font.custom(Constants.customFont, size: Constants.customFontSize))
        }
    }
}
