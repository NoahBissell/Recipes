//
//  ContentView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 1/4/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            NavigationLink(
                destination: RecipeListView(),
                label: {
                    Text("Vegan")
                })
            NavigationLink(
                destination: RecipeListView(),
                label: {
                    Text("Vegetarian")
                })
            NavigationLink(
                destination: RecipeListView(),
                label: {
                    Text("Gluten Free")
                })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
