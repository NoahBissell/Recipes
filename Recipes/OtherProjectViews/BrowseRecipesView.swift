//
//  BrowseRecipesView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/26/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct BrowseRecipesView: View {
    @EnvironmentObject var kitchen : Kitchen
    @EnvironmentObject var userInfo : UserInfo
    @State var ingredientFilter = false;
    @State var query = ""
    @State var fetchedRecipeList = [RecipeResult]()
    @State private var searchMode : SearchMode = .topRecipes
    @State var isPresentingSettingsFilter = false
    private enum SearchMode : String, CaseIterable, Identifiable {
        case search
        case topRecipes
        case forYou
        var id : String { self.rawValue}
    }
    
    var productSearchSheet : some View {
        VStack{
            Spacer()
            
            // For some reason the keyboard dismisses after typing the first character, can't seem to figure out why
            // Bug has gone away for me now, will keep this comment for reference
            
            Form{
                Section{
                    ScrollView{
                    VStack{
                        Text("Settings").font(.system(size:20))
                        Text("Diet").font(.system(size:20))
                        /*HStack{
                            Toggle(isOn: $userInfo.searchSettings.vegan, label:{
                                Text("Vegan").font(.system(size:20))
                            })
                            Toggle(isOn: $userInfo.searchSettings.vegetarian, label:{
                                Text("Vegetarian").font(.system(size:20))
                            })
                        }*/
                        Picker(selection: $userInfo.searchSettings.diet, label:
                                Text("Category"), content: {
                                    ForEach(Diet.allCases) { cat in
                                                Text(cat.rawValue.capitalized)
                                                    .tag(cat)
                                            }
                                   
                                })
                        Text("Intolerances").font(.system(size:20))
                        HStack{
                                
                        }
                    }
                    }
                    
                }
               
                
            }
        }
    }
    
    
    var body: some View {
        VStack {
            Form {
                Section{
                    if(searchMode == .search){
                        TextField(
                            "Search all recipes",
                            text: $query)
                        
                        if(query.count > 0){
                            Button("Search"){
                                Api().searchRecipes(query: query) { recipeList in
                                    self.fetchedRecipeList = recipeList
                                }
                            }
                        }
                    }
                    else{
                        Button("Generate Recipes"){
                            if(searchMode == .topRecipes) {
                                Api().getRandomRecipes { recipeList in
                                    self.fetchedRecipeList = recipeList
                                }
                            }
                            else {
                                Api().getRecipesFromIngredients(ingredients: kitchen.ingredients) { recipeList in
                                    self.fetchedRecipeList = recipeList
                                }
                            }
                        }
                    }
                }
                Section{
                    List(fetchedRecipeList){ recipeResult in
                        NavigationLink( destination:
                                            AddRecipeView(recipeResult: recipeResult)
                                        , label: {
                                            HStack {
                                                if(recipeResult.image != nil){
                                                    KFImage(recipeResult.image)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                }
                                                Text(recipeResult.title ?? "Error loading recipe")
                                            }
                                        })
                    }
                }
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Picker(selection: $searchMode, label:
                        Text("Browsing mode")
                       , content: {
                        ForEach(SearchMode.allCases){ mode in
                            Text(mode.rawValue.titleCase())
                                .tag(mode)
                            
                        }
                       })
                    .pickerStyle(SegmentedPickerStyle())
            }
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Filter") {
                    if(searchMode==SearchMode.topRecipes){
                        searchMode = SearchMode.search
                        searchMode = SearchMode.topRecipes
                        
                    }else if(searchMode==SearchMode.search){
                        searchMode = SearchMode.search
                        searchMode = SearchMode.topRecipes
                    }else{
                        searchMode = SearchMode.topRecipes
                        searchMode = SearchMode.forYou
                    }
                    self.isPresentingSettingsFilter = true
                }
                .sheet(isPresented: $isPresentingSettingsFilter){
                    productSearchSheet
                }
            }
            //            ToolbarItem(placement: .navigationBarTrailing) {
            //                Toggle("Ingredient filter", isOn: $ingredientFilter)
            //                    .toggleStyle(.switch)
            //            }
        }
    }
}


struct BrowseRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseRecipesView().environmentObject(Kitchen())
    }
}

