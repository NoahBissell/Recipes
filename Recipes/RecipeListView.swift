//
//  RecipeListView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 1/10/22.
//

import SwiftUI

struct RecipeListView: View {
    // list of recipes, have a variable that determines whether you're requesting vegan, gluten free, etc.
    var recipeMode : Mode
    var fetchRecipes = FetchData()
    
    var body: some View {
        //List
        if(recipeMode == Mode.vegan){
            Text("vegan")
        }
        else if(recipeMode == Mode.vegetarian){
            Text("vegetarian")
        }
        else{
            Text("gluten free")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(recipeMode: Mode.vegan)
    }
}
