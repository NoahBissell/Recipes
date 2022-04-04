//
//  SearchSettings.swift
//  Recipes
//
//  Created by George Lauri (student LM) on 3/18/22.
//

import SwiftUI
enum Diet : String, CaseIterable, Identifiable {
    case none
    case vegan
    case vegetarian
    case pescetarian
    case ketogenic
    case paleo
    var id : String { self.rawValue}
}
class SearchSettings{
    var vegan : Bool
    var vegetarian : Bool
    var gluten : Bool
    var dairy : Bool
    var diet : Diet


    init(vegan : Bool, vegetarian: Bool, diet: Diet = .none, gluten : Bool, dairy : Bool){
        self.vegan = vegan
        self.vegetarian = vegetarian
        self.diet = diet
        self.gluten = gluten
        self.dairy = dairy


    }
}
