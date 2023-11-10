//
//  InstructionsView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

/// A view for displaying instructions for preparing a meal.
struct InstructionsView: View {
    /// List of instruction strings for the meal
    let instructionsTexts: [String]
    
    init(instructionsTexts: [String]) {
        self.instructionsTexts = instructionsTexts
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            // MARK: - Title
            TitleView(text: "Instructions: ", textStyle: .title2, color: Constants.titleColor)
                .accessibilityLabel("Instructions")
            
            Divider()
            
            // MARK: - Instructions ScrollView
            ScrollView {
                if !instructionsTexts.isEmpty {
                    ForEach(instructionsTexts, id: \.self) { instruction in
                        Text("• " + instruction)
                            .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            .foregroundColor(Constants.textColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                } else {
                    Text("No instructions available for this meal.")
                        .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                        .foregroundColor(Constants.textColor)
                }
            }.padding()
            
            Divider()
        }
    }
}
