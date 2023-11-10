//
//  YoutubeLinkView.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/10/23.
//

import SwiftUI

struct YouTubeLinkView: View {
    let youtubeLink: String?
    
    var body: some View {
        if let link = youtubeLink, !link.isEmpty {
            VStack {
                Link("View Recipe Video", destination: URL(string: link)!)
                    .buttonStyle(LinkButtonStyle())
                    .accessibilityLabel("View Recipe Video on YouTube")
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}


