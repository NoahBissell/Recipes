//
//  NutritionView.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 3/1/22.
//

import SwiftUI

struct NutritionView: View {
	var recipe : FetchRecipe
	var nutlist : [Nutrient]
	var VitaminList: [String] = [""]
    var body: some View {
//		List(nutlist){
//			recipe.recipe.nutrition?.ElementAsText($0)
//		}
        Text("placeholder")
    }
}

struct NutritionView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionView(recipe: FetchRecipe(name: 716426), nutlist: [Nutrient]())
    }
}
