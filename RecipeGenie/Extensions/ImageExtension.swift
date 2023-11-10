//
//  ImageExtension.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

extension Image {
    func applyCommonModifiers(imageHeight: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity, maxHeight: imageHeight)
            .padding(.horizontal, 5)
            .cornerRadius(10)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .scaledToFit()
    }
}

