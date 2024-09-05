//
//  Binding+Extension.swift
//  CocktailBook
//
//  Created by Akash Jambhulkar on 05/09/24.
//

import Foundation
import SwiftUI

extension Binding {
    @MainActor
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
