//
//  LinkButtonStyle.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

struct LinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10) // Add padding
            .background(Color.gray) // Background color for the button
            .foregroundColor(Color.white) // Text color
            .cornerRadius(5) // Add corner radius
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Apply a scale effect on press
    }
}
