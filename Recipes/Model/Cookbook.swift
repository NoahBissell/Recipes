//
//  Cookbook.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 3/24/22.
//

import Foundation

class Cookbook : ObservableObject, Identifiable {
    @Published var recipes : [Recipe]
    
    init(recipes : [Recipe] = [Recipe]()){
        self.recipes = recipes
    }
    
    func addRecipe(recipe : Recipe){
        recipes.append(recipe)
    }
    func removeRecipe(at offsets: IndexSet){
        recipes.remove(atOffsets: offsets)
    }
}
