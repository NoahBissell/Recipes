//
//  ScheduleMealView.swift
//  Recipes
//
//  Created by Noah Bissell on 4/17/23.
//

import SwiftUI

struct ScheduleMealView : View {
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

struct ScheduleMealView : PreviewProvider {
    static var previews: some View {
        ScheduleMealView()
    }
}
