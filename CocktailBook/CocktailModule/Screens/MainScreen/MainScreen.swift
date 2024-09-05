//
//  MainScreen.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var selectedSegment: CocktailType = .all
    @ObservedObject var cocktailVM = CocktailViewModel(api: FakeCocktailsAPI())
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedSegment.onChange(selectCocktail)) {
                    ForEach(CocktailType.allCases, id: \.self) { type in
                        Text(type.rawValue.capitalizedFirstLetter())
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    ForEach(cocktailVM.filteredCocktails) { cocktail in
                        NavigationLink(destination: DetailsScreen(cocktail: cocktail, cocktailVM: cocktailVM)) {
                            CocktailRowView(cocktail: cocktail, isFavorite: cocktailVM.isFavorite(cocktail)) {
                                cocktailVM.toggleFavorite(cocktail)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            .navigationBarTitle("All Cocktails")
        }
        .onAppear(perform: {
            cocktailVM.fetchAllCocktails()
        })
    }
    
    // MARK: - Actions
    private func selectCocktail(type: CocktailType) {
        cocktailVM.filterCocktails(by: type)
    }
}

#Preview {
    MainScreen()
}
