//
//  RecipeDetail.swift
//  Recipes
//
//  Created by Noah Bissell on 1/12/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeDetail: View {
    var recipe : Recipe
    var body: some View {
        HStack{
            KFImage(recipe.image)
            Text(recipe.title)
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: Recipe())
    }
}
