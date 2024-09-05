//
//  MainScreen.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var cocktailVM = CocktailViewModel(api: FakeCocktailsAPI())
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cocktailVM.cocktails) {  cocktail in
                    NavigationLink(destination: DetailsScreen(cocktail: cocktail)) {
                        VStack(alignment: .leading) {
                            Text(cocktail.name)
                                .font(.headline)
                            Text(cocktail.shortDescription)
                                .font(.subheadline)
                        }
                    }
                }
            }.listStyle(.plain)
            .navigationBarTitle("All Cocktails")
        }
        .onAppear(perform: {
            cocktailVM.fetchAllCocktails()
        })
    }
}

#Preview {
    MainScreen()
}
