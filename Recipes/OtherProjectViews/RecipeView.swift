//
//  RecipeView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/28/22.
//
import Foundation
import SwiftUI
import struct Kingfisher.KFImage


struct RecipeView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    var recipe : Recipe
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @State var isPresentingMakeRecipe = false
    @State var canMakeRecipe = true
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.background)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        ScrollView {
            
                VStack {
                    Text(recipe.title ?? "Loading...")
                        .font(.title)
                        .fontWeight(.semibold)
                    KFImage(recipe.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    RichText(html: recipe.instructions ?? "")
                        .lineHeight(170)
                        .imageRadius(12)
                    //.fontType(Font.system)
                    //.colorScheme(ColorScheme.automatic)
                        .colorImportant(true)
                    //.linkOpenType(.SFSafariView)
                    //.linkColor(ColorSet(light: "#007AFF", dark: "#0A84FF"))
                        .placeholder {
                            Text("Loading...")
                        }
                    Divider()
                    Text("Ingredients")
                        .font(.title2)
                        .fontWeight(.semibold)
                    LazyVGrid(columns: columns, spacing: 20) {
                        Text("Required in recipe")
                            .font(.caption2)
                        Text("What's in my kitchen")
                            .font(.caption2)
                        Text("Enough?")
                            .font(.caption2)
                        
                        ForEach(recipe.extendedIngredients){ extendedIngredient in
                            Text("\(extendedIngredient.amount, specifier: "%.1f") \(extendedIngredient.unit) of \(extendedIngredient.getName())")
                            if let kitchenIngredient = kitchens.kitchens[kitchenIndex.index].ingredients.first { ingredient in
                                ingredient.id == extendedIngredient.id
                            }{
                                Text("\(kitchenIngredient.amount, specifier: "%.1f") \(kitchenIngredient.unit) of \(kitchenIngredient.getName())")
                                if(kitchenIngredient.amount >= extendedIngredient.amount){
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.green)
                                }
                                else{
                                    Image(systemName: "multiply")
                                        .foregroundColor(.red)
                                }
                            }
                            else{
                                Text("0.0 \(extendedIngredient.unit) of \(extendedIngredient.getName())")
                                Image(systemName: "multiply")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .padding()
                    Divider()
                    //                List(recipe.extendedIngredients){ ingredient in
                    //                    Text(ingredient.name)
                    //                }
                    //                .frame(minHeight: minRowHeight * CGFloat(recipe.extendedIngredients.count + 2))
                    
                    Text("Ready in: ")
                    HStack {
                        Image(systemName: "clock")
                        Text("\(recipe.readyInMinutes ?? 30) minutes")
                            .font(.title)
                    }
                }
            
                
                .padding()
                .onAppear(perform: {
                    for extendedIngredient in recipe.extendedIngredients {
                        if let index = kitchens.kitchens[kitchenIndex.index].ingredients.firstIndex(where: { ingredient in
                            ingredient.id == extendedIngredient.id
                        }){
                            if(kitchens.kitchens[kitchenIndex.index].ingredients[index].unit != extendedIngredient.unit){
                                Api().convertUnits(ingredient: kitchens.kitchens[kitchenIndex.index].ingredients[index].name, amount: kitchens.kitchens[kitchenIndex.index].ingredients[index].amount, sourceUnit: kitchens.kitchens[kitchenIndex.index].ingredients[index].unit, targetUnit: extendedIngredient.unit) { conversion in
                                    print(conversion.targetUnit)
                                    kitchens.kitchens[kitchenIndex.index].ingredients[index].amount = conversion.targetAmount
                                    kitchens.kitchens[kitchenIndex.index].ingredients[index].unit = conversion.targetUnit
                                    if(kitchens.kitchens[kitchenIndex.index].ingredients[index].amount < extendedIngredient.amount) {
                                        canMakeRecipe = false
                                    }
                                }
                            }
                            else{
                                if(kitchens.kitchens[kitchenIndex.index].ingredients[index].amount < extendedIngredient.amount) {
                                    canMakeRecipe = false
                                }
                            }
                        }
                        else{
                            canMakeRecipe = false
                            print("HERE")
                        }
                    }
                    
                    
                })
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    //                    NavigationLink(destination:
                    //                        CookRecipeView()
                    //                    , label: {
                    //                        Button("Make this recipe"){
                    //                            isPresentingMakeRecipe = true
                    //                        }
                    //                        .sheet(isPresented: $isPresentingMakeRecipe){
                    //                            makeRecipeSheet
                    //                        }
                    //                    })
                    Button("Make this recipe"){
                        isPresentingMakeRecipe = true
                    }
                    .sheet(isPresented: $isPresentingMakeRecipe){
                        MakeRecipeSheet(canMakeRecipe: $canMakeRecipe, recipe: recipe)
                    }
                    
                }
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe()).environmentObject(Kitchens())
            .environmentObject(KitchenIndex())
    }
}

struct MakeRecipeSheet : View {
    @Binding var canMakeRecipe : Bool
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    var recipe : Recipe
    @State var isPresentingAlert : Bool = false
    func cancel () -> (){}
    func subtractIngredients() -> (){
        for extendedIngredient in recipe.extendedIngredients {
            if let index = kitchens.kitchens[kitchenIndex.index].ingredients.firstIndex(where: { ingredient in
                ingredient.id == extendedIngredient.id
            }){
                kitchens.kitchens[kitchenIndex.index].ingredients[index].amount = kitchens.kitchens[kitchenIndex.index].ingredients[index].amount - extendedIngredient.amount
                if(kitchens.kitchens[kitchenIndex.index].ingredients[index].amount < 0){
                    kitchens.kitchens[kitchenIndex.index].ingredients.remove(at: index)
                }
            }
        }
    }
    
    var body : some View {
        VStack{
            if (!canMakeRecipe){
                Text("It looks like you don't have enough ingredients logged in your kitchen to make this recipe.")
            }
            else if(canMakeRecipe){
                Text("You have enough ingredients to make this recipe.")
                
            }
            Button("Subtract ingredients"){
                if(!canMakeRecipe){
                    isPresentingAlert = true
                }
                else{
                    subtractIngredients()
                }
            }
            .alert(isPresented: $isPresentingAlert){
                Alert(title: Text("Are you sure you would like to make this recipe?") , message: Text("You don't have enough in ingredients in your kitchen to make it."),
                      primaryButton: Alert.Button.default(
                        Text("Yes"),
                        action: subtractIngredients),
                      secondaryButton: Alert.Button.destructive(
                        Text("Cancel"),
                        action: cancel))
            }
        }
    }
}
