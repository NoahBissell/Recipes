//  ContentView.swift
//  Recipes
//  Created by Liam Shack (student LM) on 1/4/22.

import SwiftUI

var vegan = FetchData(diet : "vegan")
var vegetarian = FetchData(diet : "vegetarian")
var gluten = FetchData(diet : "gluten")
var paleo = FetchData(diet : "paleo")
var pescetarian = FetchData(diet : "pescetarian")

struct ImageOverlay: View{
    var body: some View{
        VStack{
            ZStack{
                NavigationView {
                    List{
                        Text("Dietary Eatery")
                            .font(.title)
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: vegan),
                            label: {
                                Text("Vegan")
                                    .foregroundColor(.black)
                            })
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: vegetarian),
                            label: {
                                Text("Vegetarian")
                            })
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: gluten),
                            label: {
                                Text("Gluten Free")
                            })
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: paleo),
                            label: {
                                Text("Paleo")
                            })
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: pescetarian),
                            label: {
                                Text("Pescetarian")
                            })
                    }
                }
                .background(Color.clear)
                .opacity(0.85)
                //End of NavigationView
            }
        }
    }
}



struct ContentView: View {
    var body: some View {
        VStack{
            HStack(){
                Image("Homebackground")
                    .resizable()
                    //.frame(width: 400, height: 950)
                    .overlay(ImageOverlay(), alignment: .bottomTrailing)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
