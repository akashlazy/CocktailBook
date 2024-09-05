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
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "timer")
                    Text("\(cocktail.preparationMinutes) minutes")
                        .font(.headline)
                }
                .padding(.horizontal)
                
                Image(cocktail.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text(cocktail.longDescription)
                    .font(.caption)
                    .padding(.horizontal)
                
                Text("Ingredients")
                    .font(.headline)
                    .padding()
                
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    HStack {
                        Image(systemName: "arrowtriangle.right.fill")
                        Text(ingredient)
                    }
                    .font(.subheadline)
                }
                .padding(.horizontal)
                
            }
        }
        .navigationBarTitle(cocktail.name)
    }
}

#Preview {
    NavigationView {
        DetailsScreen(cocktail: Cocktail(id: "1", name: "Piña colada", type: .alcoholic, shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.", longDescription: "The Piña Colada is a Puerto Rican rum drink made with pineapple juice (the name means “strained pineapple” in Spanish) and cream of coconut. By most accounts, the modern-day Piña Colada seems to have originated from a 1954 version that bartender named Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel in San Juan, Puerto Rico. While you may not be sipping this icy-cold tiki drink on the beaches of Puerto Rico, it’s sure to get you in a sunny mood no matter the season.", preparationMinutes: 2, imageName: "pinacolada", ingredients: ["4 oz rum","3 oz fresh pineapple juice, chilled (or use frozen pineapple chunks for a smoothie-like texture)","2 oz cream of coconut (or use a combination of sweetened coconut cream and coconut milk)","1 ounce freshly squeezed lime juice (optional)","2 cups ice", "Fresh pineapple, for garnish"]))
    }
}
