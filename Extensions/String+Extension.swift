//
//  String+Extension.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import Foundation

extension String {
    func capitalizedFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.dropFirst()
    }
}
