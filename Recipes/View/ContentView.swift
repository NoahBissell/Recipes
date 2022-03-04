//  ContentView.swift
//  Recipes
//  Created on 1/4/22.
//  Modified on 1/10/22, 1/11/22, 1/12/22, 1/18/22, 1/19/22, 1/21/22, and 1/24/22.
//  Co-Authors: Eric Nie, Liam Shack
//  Contributors: Noah Bissell, George Lauri
//  Displays view containing background image, overlays a navigation view and interface on top of such allowing for navigation to various different diet types
import SwiftUI
//declares and intializes FetchData variables for each type of diet
var vegan = FetchData(diet : "vegan")
var vegetarian = FetchData(diet : "vegetarian")
var gluten = FetchData(diet : "gluten")
var paleo = FetchData(diet : "paleo")
var pescetarian = FetchData(diet : "pescetarian")

// creates the ImageOverlay to display over ContentView
struct ImageOverlay: View{
    var body: some View{
        VStack{
            ZStack{
                //creates navigationg view
                NavigationView {
                    //creates list displaying initial text and a navigation link to each diet type
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
                //sets opacity and background color
                //End of NavigationView
            }
        }
    }
}



struct ContentView: View {
    /*------------------------------------------*/
    // Old project
    @EnvironmentObject var userInfo : UserInfo
    var body: some View {
        VStack{
            HStack(){
                //displays background image and overlays ImageOverlay over it
                Image("Homebackground")
                    .resizable()
                    .overlay(ImageOverlay(), alignment: .bottomTrailing)
            }
        }
        
/*------------------------------------------*/
// Uncomment to use other project
//        if(userInfo.loggedIn){
//            MainView()
//        }
//        else{
//            LoginView()
//        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //displays preview
        ContentView()
    }
}
