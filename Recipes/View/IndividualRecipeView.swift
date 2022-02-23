//  IndividualRecipeView.swift
//  Recipes
//  Created on 1/12/22.
//  Modified on 1/21/22, 1/24/22, 1/26/22.
//  Co-Authors: Noah Bissell, George Lauri
//  Contributor: Liam Shack
//  Provides more detailed view for specific recipes after navigation from RecipeListView

import SwiftUI
import struct Kingfisher.KFImage

struct IndividualRecipeView: View {
    //takes input of recipe from which to derive the specific text and images used in the view
    var recipe : FetchRecipe
    
    var body: some View {
        
        VStack{
            //creates scrollview to allow scrolling
            ScrollView{
                //displays title
                Text(recipe.recipe.title ?? "Error loading")
                //displays and frames image so as to restrict its height
                KFImage(recipe.recipe.image)
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 100, idealHeight: 200, maxHeight: 250, alignment:.center)
                //displays summart, instructions, and time to cook
                Text(recipe.recipe.summary ?? "Error loading")
                Text(recipe.recipe.instructions ?? "Error loading")
                if let mins = recipe.recipe.readyInMinutes{
                    Text("Ready in \(mins) minutes.")
                }
            }
        //frames VStack to restrict width
        }.frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 400, idealHeight: 800, maxHeight: 2000, alignment:.center)
    }
}

struct IndividualRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        //creates preview
        IndividualRecipeView(recipe: FetchRecipe(name: 716426))
    }
}
