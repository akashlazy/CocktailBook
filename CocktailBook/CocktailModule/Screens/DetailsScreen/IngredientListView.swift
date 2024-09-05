//
//  IngredientListView.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct IngredientListView: View {
    let ingredients: [String]
    
    var body: some View {
        ForEach(ingredients, id: \.self) { ingredient in
            HStack {
                Image(systemName: "arrowtriangle.right.fill")
                Text(ingredient)
            }
            .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    IngredientListView(ingredients: sampleCocktail.ingredients)
}
