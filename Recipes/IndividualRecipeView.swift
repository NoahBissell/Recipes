//
//  IndividualRecipeView.swift
//  Recipes
//
//  Created by Noah Bissell on 1/12/22.
//

import SwiftUI

struct IndividualRecipeView: View {
    var recipe : Result
    
    var body: some View {
        Text("Placeholder")
    }
}

struct IndividualRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualRecipeView(recipe: Result(id: 123))
    }
}
