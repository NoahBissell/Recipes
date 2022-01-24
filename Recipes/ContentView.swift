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
            Spacer(minLength: 80)
            ZStack{
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 400, height: 100)
                    .offset(x:0, y:-485)
                    .opacity(0.65)
                NavigationView {
                    List{
                        Text("             Dietary Eatery")
                            .font(.title)
                        Text("***********************************************")
                        Spacer(minLength: 100)
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
                        Spacer(minLength: 100)
                        Text("***********************************************")
                    }
                }.padding(0)
                .background(Color.clear)//End of NavigationView
                .opacity(0.65)
            }
            
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
