//
//  ContentView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
        NavigationView {
            List{
                NavigationLink(
                    destination: RecipeListView(recipeMode: "vegan"),
                    label: {
                        Text("Vegan")
                    })
                NavigationLink(
                    destination: RecipeListView(recipeMode: "vegetarian"),
                    label: {
                        Text("Vegetarian")
                    })
                NavigationLink(
                    destination: RecipeListView(recipeMode: "glutenFree"),
                    label: {
                        Text("Gluten Free")
                    })
            }
        }
        
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
