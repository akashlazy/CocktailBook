//
//  CocktailRowView.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct CocktailRowView: View {
    let cocktail: Cocktail
    let isFavorite: Bool
    let toggleFavorite: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cocktail.name)
                    .foregroundColor(isFavorite ? .purple : .primary)
                Spacer()
                FavoriteButton(isFavorite: isFavorite) {
                    withAnimation {
                        toggleFavorite()
                    }
                }
            }
            Text(cocktail.shortDescription)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    CocktailRowView(cocktail: sampleCocktail, isFavorite: true, toggleFavorite: {
        
    })
}
