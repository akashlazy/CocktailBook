//
//  MainScreen.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import SwiftUI

struct MainScreen: View {
    
    @State private var selectedSegment: CocktailType = .all
    @ObservedObject var cocktailVM = CocktailViewModel(api: FakeCocktailsAPI(withFailure: .count(1)))
    @State private var hasLoaded = false
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle("All Cocktails")
                .onAppear {
                    if !hasLoaded { // Only fetch if it hasn't been loaded yet
                        cocktailVM.fetchAllCocktails()
                        hasLoaded = true
                    }
                }
        }
    }
    
    // MARK: - View Components
    @ViewBuilder
    private var content: some View {
        if cocktailVM.isLoading {
            ActivityIndicator(isAnimating: $cocktailVM.isLoading)
        } else {
            VStack {
                segmentPicker
                cocktailListView
            }
        }
    }
    
    private var segmentPicker: some View {
        Picker("", selection: $selectedSegment.onChange(selectCocktail)) {
            ForEach(CocktailType.allCases, id: \.self) { type in
                Text(type.rawValue.capitalizedFirstLetter())
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
    
    private var cocktailListView: some View {
        Group {
            if let errorMessage = cocktailVM.errorMessage {
                errorView(errorMessage)
            } else {
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
        }
    }
    
    private func errorView(_ errorMessage: String) -> some View {
        VStack {
            Spacer()
            Text(errorMessage)
                .foregroundColor(.red)
            Spacer()
        }
    }
    
    // MARK: - Actions
    private func selectCocktail(type: CocktailType) {
        cocktailVM.filterCocktails(by: type)
    }
}

#Preview {
    MainScreen()
}
