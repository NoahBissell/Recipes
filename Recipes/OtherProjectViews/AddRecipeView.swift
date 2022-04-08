//
//  AddRecipeView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/27/22.
//
 
import SwiftUI
import struct Kingfisher.KFImage
 
 
struct AddRecipeView: View {
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    var recipeResult : RecipeResult
    @State var isSaved = false
    @State var isRecipeLoaded = false
    @State var recipe = Recipe()
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(recipe.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                //                Text(recipe.summary?.removeHtmlTags() ?? "Loading...")
                if(isRecipeLoaded) {
                    RichText(html: recipe.summary ?? "Loading...")
                        .lineHeight(170)
                        .imageRadius(12)
                        .fontType(.system)
                        .colorScheme(.automatic)
                        .colorImportant(true)
                        .linkOpenType(.SFSafariView)
                        //.linkColor(ColorSet(light: "#007AFF", dark: "#0A84FF"))
                        .placeholder {
                            Text("Loading...")
                        }
                }
                Text("Ready in: ")
                HStack {
                    Image(systemName: "clock")
                    Text("\(recipe.readyInMinutes ?? 45) minutes")
                        .font(.title)
                }
            }
            .onAppear {
                Api().getRecipeFromId(id: recipeResult.id) { recipe in
                    self.recipe = recipe
                    
                    isSaved = kitchens.kitchens[kitchenIndex.index].recipes.contains(where: { recipe in
                        return self.recipe.id == recipe.id
                    })
                    isRecipeLoaded = true
                }
                
            }
            .padding()
            .navigationBarItems(trailing:
                                    HStack{
                                        if(!isSaved){
                                            Button (action: {
                                                kitchens.kitchens[kitchenIndex.index].addRecipe(recipe: recipe)
                                                isSaved = true
                                            }, label: {
                                                if #available(iOS 14.5, *) {
                                                    Label("Favorite", systemImage: "")
                                                        .labelStyle(TitleAndIconLabelStyle())
                                                } else {
                                                    Label("Favorite", systemImage: "")
                                                }
                                            })
                                        }
                                        
                                        
                                        
                                        
                                        else{
                                            if #available(iOS 14.5, *) {
                                                Label("", systemImage: "star")
                                                    .labelStyle(TitleAndIconLabelStyle())
                                            } else {
                                                Text("Saved")
                                            }
                                        }
                                    }
            )
        }
        .navigationTitle(recipeResult.title ?? "")
        .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
    }
}
 
struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(recipeResult: RecipeResult()).environmentObject(Kitchen())
    }
}



