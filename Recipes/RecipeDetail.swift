//  RecipeDetail.swift
//  Recipes
//  Created on 1/12/22.
//  Modified on 1/24/22
//  Author: Noah Bissell
//  Contributor: George Lauri
//  Provides view for recipes within RecipeListView

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeDetail: View {
    //takes input of Result from which it draws the image and title seen later
    var recipe : Result
    var body: some View {
        VStack{
            //displays image and makes it resizeable
            KFImage(recipe.image)
                .resizable()
            //displays title below image
            Text(recipe.title ?? "Error loading this recipe")
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        //displays preview
        RecipeDetail(recipe: Result(id: 123))
    }
}
