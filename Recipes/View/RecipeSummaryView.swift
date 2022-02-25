//
//  RecipeSummaryView.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 2/23/22.
//

import SwiftUI

struct RecipeSummaryView: View {
	var recipe : FetchRecipe
    var body: some View {
		VStack{
			recipe.recipe.nutrition?.ElementAsText("Calories")
			if let calories = recipe.recipe.nutrition?.nutrients.first(where: {$0.name == "Calories"}){
				Text("Calories: \(String(calories.amount ?? 0)) \(calories.unit ?? "")")
			}
			else{
				Text("Calories: unknown")
			}
		}
    }
}

struct RecipeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSummaryView(recipe: FetchRecipe(name: 716426))
    }
}
