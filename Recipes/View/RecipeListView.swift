//  RecipeListView.swift
//  Recipes
//  Created on 1/10/22.
//  Modified on 1/11/22, 1/12/22, 1/18/22, 1/19/22, 1/21/22, and 1/24/22.
//  Co-Authors: Noah Bissell, George Lauri
//  Contributors: Eric Nie
//  Displays Recipes to naviagate to in a simplified list format, allows navigation to those recipes

import SwiftUI

struct RecipeListView: View {
    // list of recipes, have a variable that determines whether you're requesting vegan, gluten free, etc.
    // takes a bound fetchRecipes from ContentView to display as a list
    @StateObject var fetchRecipes : FetchData
    
    var body: some View {
        //displays all responses in fetchRecipes
        List(fetchRecipes.responses.results){ result in
            //navigates to IndividualRecipeView
            NavigationLink(
                destination:
                    RecipeSummaryView(recipe: FetchRecipe(name: result.id)),
                label: {
                    //Diplays the Recipe detail needed to navigate to Individual Recipe view, provides a label to choose a recipe to view in detail
                    RecipeDetail(recipe: result)
                        .frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 100, idealHeight: 300, maxHeight: 500, alignment:.center)
                })
        }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        //displays preview
        RecipeListView(fetchRecipes: FetchData(diet : "Vegan"))
    }
}
