//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import Foundation
import Combine

class CocktailViewModel: ObservableObject {
    
    private let api: FakeCocktailsAPI
    private var cancellables = Set<AnyCancellable>()
    private var cocktails: [Cocktail] = []
    @Published var filteredCocktails: [Cocktail] = []
    
    @Published var favoriteCocktails: [String] = [] {
        didSet {
            handleFavoriteChange()
        }
    }
    
    // MARK: - Initializer
    init(api: FakeCocktailsAPI) {
        self.api = api
        loadFavorites()
    }
    
    // MARK: - API Calls
    func fetchAllCocktails() {
        api.cocktailsPublisher
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("Finished Successfully")
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }, receiveValue: {[weak self] data in
                do {
                    let json = try JSONDecoder().decode([Cocktail].self, from: data)
                    self?.cocktails = json
                    self?.filteredCocktails = json
                    self?.updateCocktailList()
                } catch {
                    print(error)
                }
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Filtering
    func filterCocktails(by type: CocktailType) {
        filteredCocktails = (type == .all) ? cocktails : cocktails.filter { $0.type == type }
        updateCocktailList()
    }
    
    private func handleFavoriteChange() {
        saveFavorites()
        updateCocktailList()
    }
    
    private func updateCocktailList() {
        sortCocktailsByName()
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
}

