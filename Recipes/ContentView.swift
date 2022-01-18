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
                Text("")
                NavigationLink(
                    destination: RecipeListView(recipeMode: Mode.vegan),
                    label: {
                        Text("Vegan")
                    })
                NavigationLink(
                    destination: RecipeListView(recipeMode: Mode.vegetarian),
                    label: {
                        Text("Vegetarian")
                    })
                NavigationLink(
                    destination: RecipeListView(recipeMode: Mode.glutenFree),
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
