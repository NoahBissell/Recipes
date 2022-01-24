//
//  RecipeListView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 1/10/22.
//

import SwiftUI

struct RecipeListView: View {
    // list of recipes, have a variable that determines whether you're requesting vegan, gluten free, etc.
    
    @StateObject var fetchRecipes : FetchData
    
    var body: some View {
        
        List(fetchRecipes.responses.results){ result in
            NavigationLink(
                destination:
                    IndividualRecipeView(recipe: FetchRecipe(name: result.id)),
                label: {
                    RecipeDetail(recipe: result)
                        .frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 100, idealHeight: 300, maxHeight: 500, alignment:.center)
                })
        }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(fetchRecipes: FetchData(diet : "Vegan"))
    }
}
