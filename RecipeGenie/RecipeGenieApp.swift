//
//  RecipeGenieApp.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/6/23.
//

import SwiftUI

@main
struct RecipeGenieApp: App {
    var body: some Scene {
        WindowGroup {
            MealsView()
                .font(Font.custom(Constants.customFont, size: Constants.customFontSize))
        }
    }
}
