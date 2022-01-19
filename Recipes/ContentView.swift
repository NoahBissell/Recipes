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
            Spacer(minLength: 75)
            Text("Recipes")
        NavigationView {
            List{
                NavigationLink(
                    destination: RecipeListView(fetchRecipes: FetchData(diet : "vegan")),
                    label: {
                        Text("Vegan")
                    })
                NavigationLink(
                    destination: RecipeListView(fetchRecipes: FetchData(diet : "vegetarian")),
                    label: {
                        Text("Vegetarian")
                    })
                NavigationLink(
                    destination: RecipeListView(fetchRecipes: FetchData(diet : "gluten")),
                    label: {
                        Text("Gluten Free")
                    })
                NavigationLink(
                    destination: RecipeListView(fetchRecipes: FetchData(diet : "paleo")),
                    label: {
                        Text("Paleo")
                    })
                NavigationLink(
                    destination: RecipeListView(fetchRecipes: FetchData(diet : "pescetarian")),
                    label: {
                        Text("Pescetarian")
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
