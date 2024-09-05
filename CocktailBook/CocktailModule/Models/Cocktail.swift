//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import Foundation

struct Cocktail: Identifiable, Decodable {
    let id, name: String
    let type: CocktailType
    let shortDescription, longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
}

enum CocktailType: String, Decodable, CaseIterable {
    case all = "all"
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
}


#if DEBUG
let sampleCocktail = Cocktail(id: "1",
    name: "Piña Colada",
    type: .alcoholic,
    shortDescription: "Velvety-smooth texture and a taste of the tropics are what this tropical drink delivers.",
    longDescription: """
        The Piña Colada is a Puerto Rican rum drink made with pineapple juice and cream of coconut.
        It originated from a 1954 version that bartender Ramón “Monchito” Marrero Perez shook up at The Caribe Hilton hotel.
        """,
    preparationMinutes: 2,
    imageName: "pinacolada",
    ingredients: [
        "4 oz rum",
        "3 oz fresh pineapple juice",
        "2 oz cream of coconut",
        "1 oz freshly squeezed lime juice",
        "2 cups ice",
        "Fresh pineapple, for garnish"
    ]
)
#endif
    
