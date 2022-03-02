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

//creates the ImageOverlay to display over ContentView
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
    var body: some View {
        VStack{
            HStack(){
                //displays background image and overlays ImageOverlay over it
                Image("Homebackground")
                    .resizable()
                    .overlay(ImageOverlay(), alignment: .bottomTrailing)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //displays preview
        ContentView()
    }
}





// Other ContentView

//
//  ContentView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell (student LM) on 1/9/22.
//

//import SwiftUI
//
//struct ContentView: View {
//
//    @EnvironmentObject var kitchen : Kitchen
//
//    var body : some View {
//
//
//        TabView{
//
//            KitchenView()
//                .tabItem(){
//                    if #available(iOS 14.5, *) {
//                        Label("Kitchen", systemImage: "house")
//                            .labelStyle(TitleAndIconLabelStyle())
//                    } else {
//                        Text("Kitchen")
//                    }
//                }
//
//            CookbookView()
//                .tabItem(){
//                    if #available(iOS 14.5, *) {
//                        Label("Cookbook", systemImage: "text.book.closed")
//                            .labelStyle(TitleAndIconLabelStyle())
//                    } else {
//                        Text("Cookbook")
//                    }
//
//                }
//            SettingsView()
//                .tabItem(){
//                    if #available(iOS 14.5, *) {
//                        Label("Settings", systemImage: "gear")
//                            .labelStyle(TitleAndIconLabelStyle())
//                    } else {
//                        Text("Settings")
//                    }
//                }
//        }
//
//
//
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environmentObject(Kitchen())
//    }
//}
//
