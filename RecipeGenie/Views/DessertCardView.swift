//
//  DessertCardView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/9/23.
//

import SwiftUI

/// A view for displaying a dessert card, including an image.
struct DessertCardView: View {
    /// The URL of the image.
    let url: String?
    
    /// The desired height of the displayed image.
    let imageHeight: CGFloat
    
    /// Creates a view for displaying a dessert card.
    /// - Parameters:
    ///   - url: The URL of the image.
    ///   - imageHeight: The desired height of the displayed image.
    init(url: String?, imageHeight: CGFloat) {
        self.url = url
        self.imageHeight = imageHeight
    }
    
    var body: some View {
        VStack {
            if let mealUrl = url, let imageURL = URL(string: mealUrl) {
                AsyncImage(url: imageURL) { phase in
                    if let image = phase.image {
                        image.applyCommonModifiers(imageHeight: imageHeight)
                    } else if phase.error != nil {
                        Image("dessert_image").applyCommonModifiers(imageHeight: imageHeight)
                    } else {
                        ProgressView()
                            .accessibility(hidden: true)
                    }
                }
                .accessibility(label: Text("Dessert Image"))
            } else {
                Image("dessert_image").applyCommonModifiers(imageHeight: imageHeight)
                    .accessibility(label: Text("Dessert Image"))
            }
        }
    }
}
