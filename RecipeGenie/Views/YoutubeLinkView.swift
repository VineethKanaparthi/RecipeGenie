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
        if let link = youtubeLink, !link.isEmpty, let url = URL(string: link) {
            // MARK: - Link to YouTube Video
            VStack {
                Link(destination: url){
                    HStack {
                        Image(systemName: "play.rectangle.fill") // YouTube-like play icon
                            .foregroundColor(.red)
                        Text("View Recipe Video")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(LinkButtonStyle())
                .accessibilityLabel("View Recipe Video on YouTube")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}


