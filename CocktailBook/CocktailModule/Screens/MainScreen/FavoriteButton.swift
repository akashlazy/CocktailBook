//
//  FavoriteButton.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct FavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .foregroundColor(isFavorite ? .purple : .gray)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    FavoriteButton(isFavorite: true, action: {
        
    })
}
