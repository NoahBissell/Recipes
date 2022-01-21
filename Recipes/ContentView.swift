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
            Spacer(minLength: 150)
            ZStack{
                NavigationView {
                    List{
                        NavigationLink(
                            destination: RecipeListView(fetchRecipes: vegan),
                            label: {
                                Text("Vegan")
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
                }//End of NavigationView
            }.background(Color.black)
            .opacity(0.5)
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack{
            Spacer(minLength: 80)
            HStack(){
                Spacer(minLength: 5)
                Image("Homebackground")
                    .resizable()
                    .frame(width: 400, height: 950)
                    .overlay(ImageOverlay(), alignment: .bottomTrailing)
                Spacer()
                Divider()
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



