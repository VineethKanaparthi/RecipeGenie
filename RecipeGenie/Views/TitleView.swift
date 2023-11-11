//
//  TitleView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

/// A SwiftUI view for displaying a title with customizable text, text style, and text color.
struct TitleView: View {
    /// The text to be displayed as the title.
    let text: String
    
    /// The preferred text style for the title.
    let textStyle: UIFont.TextStyle
    
    /// The preferred text color for the title.
    let color: Color

    var body: some View {
        // MARK: - Title
        Text(text)
            .bold()
            .multilineTextAlignment(.center)
            .font(Font.custom(Constants.customFont, size: UIFont.preferredFont(forTextStyle: textStyle).pointSize))
            .foregroundColor(color)
            .padding(5)
            .accessibilityLabel(text) 
    }
}
