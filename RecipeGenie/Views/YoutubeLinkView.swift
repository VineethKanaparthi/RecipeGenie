//
//  YoutubeLinkView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

/// A view for displaying a link to a recipe video on YouTube.
struct YouTubeLinkView: View {
    /// youtube link associated with this view
    let youtubeLink: String?
    
    var body: some View {
        if let link = youtubeLink, !link.isEmpty {
            // MARK: - Link to YouTube Video
            VStack {
                Link("View Recipe Video", destination: URL(string: link)!)
                    .buttonStyle(LinkButtonStyle())
                    .accessibilityLabel("View Recipe Video on YouTube")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}


