//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import Foundation
import Combine

class CocktailViewModel: ObservableObject {
    
    // MARK: - Properties
    private let api: CocktailsAPI
    private var cancellables = Set<AnyCancellable>()
    private var cocktails: [Cocktail] = []
    
    @Published var filteredCocktails: [Cocktail] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    @Published var favoriteCocktails: [String] = [] {
        didSet {
            handleFavoriteChange()
        }
    }
    
    // MARK: - Initializer
    init(api: CocktailsAPI) {
        self.api = api
        loadFavorites()
    }
    
    // MARK: - API Calls
    func fetchAllCocktails() {
        isLoading = true
        api.cocktailsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleCocktailData)
            .store(in: &cancellables)
    }
    
    // MARK: - Filtering
    func filterCocktails(by type: CocktailType) {
        filteredCocktails = (type == .all) ? cocktails : cocktails.filter { $0.type == type }
        if filteredCocktails.isEmpty && errorMessage == nil {
            errorMessage = "No Data Available"
        } else {
            updateCocktailList()
        }
    }
    
    // MARK: - Favorites Handling
    func isFavorite(_ cocktail: Cocktail) -> Bool {
        return favoriteCocktails.contains(cocktail.id)
    }
    
    func toggleFavorite(_ cocktail: Cocktail) {
        if isFavorite(cocktail) {
            favoriteCocktails.removeAll { $0 == cocktail.id }
        } else {
            favoriteCocktails.append(cocktail.id)
        }
    }
    
    // MARK: - Private Methods
    private func handleCompletion(_ completion: Subscribers.Completion<CocktailsAPIError>) {
        switch completion {
        case .finished:
            isLoading = false
        case .failure(let error):
            isLoading = false
            errorMessage = error.localizedDescription
        }
    }
    
    private func handleCocktailData(_ data: Data) {
        do {
            cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
            filteredCocktails = cocktails
            updateCocktailList()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func handleFavoriteChange() {
        saveFavorites()
        updateCocktailList()
    }
    
    // Update the list of cocktails whenever favorites change
    private func updateCocktailList() {
        sortCocktailsByName()
        reorderCocktailsByFavorites()
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(favoriteCocktails, forKey: "favorites")
    }
    
    private func loadFavorites() {
        favoriteCocktails = UserDefaults.standard.stringArray(forKey: "favorites") ?? []
    }
    
    private func sortCocktailsByName() {
        filteredCocktails.sort { $0.name < $1.name }
    }
    
    private func reorderCocktailsByFavorites() {
        let favorite = filteredCocktails.filter { favoriteCocktails.contains($0.id) }
        let nonFavorite = filteredCocktails.filter { !favoriteCocktails.contains($0.id) }
        filteredCocktails = favorite + nonFavorite
    }
}

