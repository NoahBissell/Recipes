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
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 100, idealHeight: 200, maxHeight: 250, alignment:.center)
                Text(recipe.recipe.summary ?? "Error loading")
                Text(recipe.recipe.instructions ?? "Error loading")
                if let mins = recipe.recipe.readyInMinutes{
                    Text("Ready in \(mins) minutes.")
                }
            }
        }.frame(minWidth: UIScreen.main.bounds.width*0.9, idealWidth: UIScreen.main.bounds.width*0.9, maxWidth: UIScreen.main.bounds.width*0.9, minHeight: 400, idealHeight: 800, maxHeight: 2000, alignment:.center)
    }
}

struct IndividualRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualRecipeView(recipe: FetchRecipe(name: 716426))
    }
}
