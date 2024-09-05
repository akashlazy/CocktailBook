//
//  DetailsScreen.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct DetailsScreen: View {
    
    let cocktail: Cocktail
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                DetailHeaderView(cocktail: cocktail)
                    .padding(.horizontal)
                
                Image(cocktail.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(cocktail.longDescription)
                    .font(.caption)
                    .padding(.horizontal)
                
                Text("Ingredients")
                    .font(.headline)
                    .padding(.horizontal)
                
                IngredientListView(ingredients: cocktail.ingredients)
            }
            .navigationBarTitle(cocktail.name)
        }
    }
}

#Preview {
    NavigationView {
        DetailsScreen(cocktail: sampleCocktail)
    }
}

