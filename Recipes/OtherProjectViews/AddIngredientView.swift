//
//  AddIngredientView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/25/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct AddIngredientView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var presentView : Bool
    @ObservedObject var kitchen : Kitchen
    @EnvironmentObject var userInfo : UserInfo
    //    @EnvironmentObject var kitchens : Kitchens
    //    @EnvironmentObject var kitchenIndex : KitchenIndex
    @State var ingredient = Ingredient()
    @State var searchedIngredientList = [IngredientResult]()
    @State var isPresentingIngredientSearch = false
    @State var query : String = ""
    @State var selectedUnits = ""
    
    var ingredientSearchSheet : some View {
        
        VStack{
            Spacer()
            
            // For some reason the keyboard dismisses after typing the first character, can't seem to figure out why
            // Bug has gone away for me now, will keep this comment for reference
            Form{
                Section{
                    TextField(
                        "Search all ingredients",
                        text: $query)
                    
                    if(query.count > 0){
                        Button("Search"){
                            Api().searchIngredients(query: query) { ingredientList in
                                self.searchedIngredientList = ingredientList
                            }
                        }
                    }
                    
                }
                Section{
                    List(searchedIngredientList){ ingredientResult in
                        Button(ingredientResult.name?.capitalized ?? "Error Loading Product"){
                            Api().getIngredientFromId(id: ingredientResult.id) { ingredient in
                                self.ingredient = ingredient
                                self.ingredient.unit = ingredient.possibleUnits.first ?? ""
                            }
                            self.isPresentingIngredientSearch = false
                        }
                    }
                }
            }
            
        }
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.background)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    if(ingredient.image != nil){
                        KFImage(ingredient.getImageURL())
                            .padding()
                    }
                    
                    VStack(spacing: 20){
                        if(ingredient.name == "None") {
                            Text("New ingredient")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        else {
                            Text("Ingredient: \(ingredient.name)")
                                .font(.title2)
                                .fontWeight(.light)
                                .padding()
                        }
                        
                        
                        
                        Stepper(value: $ingredient.amount, in: 0.1...100.0, step: 0.1) {
                            Text("Amount: \(ingredient.amount, specifier: "%.1f")")
                        }
                        .padding()
                        
                        HStack{
                            Text("Units: ")
                            Picker("Units", selection: $ingredient.unit) {
                                ForEach(ingredient.possibleUnits, id: \.self){ unit in
                                    Text(unit)
                                }
                            }
                            .id(ingredient.possibleUnits)
                            .pickerStyle(MenuPickerStyle())
                        }
                        .padding()
                        
                        Button("Search for an ingredient"){
                            self.isPresentingIngredientSearch = true
                        }
                        .sheet(isPresented: $isPresentingIngredientSearch){
                            ingredientSearchSheet
                        }
                        .padding()
                    }
                    .frame(width: geo.size.width * 0.9)
                    .background(Color.foreground)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
            }
//            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if(ingredient.name != "None"){
                        Button (action: {
                            kitchen.addIngredient(ingredient: ingredient)
                            FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                                //
                            }
                            presentView = false;
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Add ingredient")
                        })
                    }
                    else{
                        Text("Add ingredient")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}


struct AddIngredientView_Previews: PreviewProvider {
    static var previews: some View {
        AddIngredientView(presentView: .constant(true), kitchen: Kitchen())
            .environmentObject(UserInfo())
    }
}
