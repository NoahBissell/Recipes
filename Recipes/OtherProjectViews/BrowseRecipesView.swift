//
//  BrowseRecipesView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/26/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct BrowseRecipesView: View {
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
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
            Text("Filter Settings")
            .fontWeight(.semibold)
            .font(.title2)
            .alignmentGuide(.leading) { d in d[.leading]}
            Form{
                
                Section{
                    
                        
                    VStack{
                        
                            
//                            .font(.system(size:20))
                        Text("Diet")
                            .font(.title3)
//                            .font(.system(size:20))
                        Picker(selection: $userInfo.searchSettings.diet, label:
                                Text("Diet"), content: {
                                    ForEach(Diet.allCases) { cat in
                                                Text(cat.rawValue.capitalized)
                                                    .tag(cat)
                                            }
                                   
                                })
                            .pickerStyle(WheelPickerStyle())
                    }
                    }
                    Section {
                        Text("Intolerances")
                            .font(.title3)
//                            .font(.system(size:24))
                        VStack{
                            Toggle(isOn: $userInfo.searchSettings.gluten, label:{
                                Text("Gluten")
                                    .fontWeight(.thin)
//                                    .font(.system(size:20))
                            })
                            Toggle(isOn: $userInfo.searchSettings.dairy, label:{
                                Text("Dairy")
                                    .fontWeight(.thin)
//                                    .font(.system(size:20))
                            })
                        }
                        Button("Save Changes"){
                            self.isPresentingSettingsFilter = false
                        }
                    }
                Section {
                    Button("Save Changes"){
                        self.isPresentingSettingsFilter = false
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
                                Api().searchRecipes(userInfo: userInfo, query: query) { recipeList in
                                    self.fetchedRecipeList = recipeList
                                }
                            }
                        }
                    }
                    else{
                        Button("Generate Recipes"){
                            if(searchMode == .topRecipes) {
                                Api().getRandomRecipes(userInfo: userInfo) { recipeList in
                                    self.fetchedRecipeList = recipeList
                                }
                            }
                            else {
                                Api().getRecipesFromIngredients(userInfo: userInfo, ingredients: kitchens.kitchens[kitchenIndex.index].ingredients) { recipeList in
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
                    self.isPresentingSettingsFilter = true
                    if(searchMode==SearchMode.topRecipes){
                        searchMode = SearchMode.search
                        searchMode = SearchMode.topRecipes
                        
                    }else if(searchMode==SearchMode.search){
                        searchMode = SearchMode.topRecipes
                        searchMode = SearchMode.search
                    }else{
                        searchMode = SearchMode.topRecipes
                        searchMode = SearchMode.forYou
                    }
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

