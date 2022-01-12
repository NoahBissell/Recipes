//
//  IndividualRecipeView.swift
//  Recipes
//
//  Created by Noah Bissell on 1/12/22.
//

import SwiftUI

struct IndividualRecipeView: View {
    var recipe : Recipe
    var body: some View {
        Text(recipe.title)
    }
}

struct IndividualRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualRecipeView(recipe: Recipe())
    }
}
