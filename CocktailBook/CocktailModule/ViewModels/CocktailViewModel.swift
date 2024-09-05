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
    @Published var cocktails: [Cocktail] = []
    
    // MARK: - Initializer
    init(api: FakeCocktailsAPI) {
        self.api = api
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
                } catch {
                    print(error)
                }
            })
            .store(in: &cancellables)
    }
}

