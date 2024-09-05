//
//  DetailHeaderView.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct DetailHeaderView: View {
    let cocktail: Cocktail
    
    var body: some View {
        HStack {
            Image(systemName: "timer")
            Text("\(cocktail.preparationMinutes) minutes")
                .font(.headline)
        }
    }
}

#Preview {
    DetailHeaderView(cocktail: sampleCocktail)
}
