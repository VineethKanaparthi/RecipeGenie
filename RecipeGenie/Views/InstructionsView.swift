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
    
    @State private var showInstructions = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            // MARK: - Title
            HStack {
                TitleView(text: "Instructions: ", textStyle: .title2, color: Constants.titleColor)
                Spacer()
                Button(action: {
                    showInstructions.toggle()
                }) {
                    Image(systemName: showInstructions ? "chevron.up.circle" : "chevron.down.circle")
                        .foregroundColor(Color.blue)
                        .font(Font.system(size: 24))
                        .padding(.trailing, 10)
                }
            }
            .accessibilityElement(children: .combine)
            .accessibility(label: Text("Instructions"))
            .accessibility(addTraits: .isHeader)
            
            
            Divider()
            
            // MARK: - Instructions ScrollView
            if showInstructions {
                ScrollView {
                    if !instructionsTexts.isEmpty {
                        ForEach(instructionsTexts, id: \.self) { instruction in
                            Text("• " + instruction)
                                .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                                .foregroundColor(Constants.textColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 2.5)
                            
                        }
                    } else {
                        Text("No instructions available for this meal.")
                            .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            .foregroundColor(Constants.textColor)
                    }
                }.padding()
            }
            
            Divider()
        }
    }
}
