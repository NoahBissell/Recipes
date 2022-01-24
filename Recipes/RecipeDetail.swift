//
//  RecipeDetail.swift
//  Recipes
//
//  Created by Noah Bissell on 1/12/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct RecipeDetail: View {
    var recipe : Result
    var body: some View {
        VStack{
            KFImage(recipe.image)
                .resizable()
            Text(recipe.title ?? "Error loading this recipe")
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: Result(id: 123))
    }
}
