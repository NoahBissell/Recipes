//
//  IndividualRecipeView.swift
//  Recipes
//
//  Created by Noah Bissell on 1/12/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct IndividualRecipeView: View {
    var recipe : FetchRecipe
    
    var body: some View {
        VStack{
            ScrollView{
                Text(recipe.recipe.title ?? "Error loading")
                KFImage(recipe.recipe.image)
                Text(recipe.recipe.summary ?? "Error loading")
                if let mins = recipe.recipe.readyInMinutes{
                    Text("Ready in \(mins) minutes.")
                }
            }
        }
    }
}

struct IndividualRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualRecipeView(recipe: FetchRecipe(name: 716426))
    }
}
