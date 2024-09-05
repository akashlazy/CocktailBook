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
