//
//  KitchenView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/22/22.
//

import SwiftUI

struct KitchenView: View {
    @EnvironmentObject var userInfo : UserInfo
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @ObservedObject var kitchen : Kitchen
    @State var isAddViewActive = false
    @State var navigateTo : AnyView?
    
    @Binding var viewState : ViewState
    
    func deleteProduct(at offsets: IndexSet){
        kitchen.removeProduct(at: offsets)
    }
    func deleteIngredient(at offsets: IndexSet){
        kitchen.removeIngredient(at: offsets)
    }
    
    var body : some View {
        NavigationView {
            VStack{
                
                Button("Upload kitchen to firebase"){
                    FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                        if(completed) {
                            print("worked?")
                        }
                        else {
                            print("didn't work?")
                        }
                    }

                }
                
                Form{
                    Section(header: Text("All products")){
//                        List {
                        ForEach(kitchen.products.indices, id: \.self){ index in
                                NavigationLink(
                                    destination: ProductView(product: $kitchen.products[index]),
                                    
                                    label: {
                                        ProductDetail(product: kitchen.products[index])
                                    })
                                    
                            }
                            .onDelete(perform: deleteProduct)
//                        }
                    }
                    Section(header: Text("Ingredients")){
                        List {
                            ForEach(kitchen.ingredients.indices, id: \.self){ index in
                                NavigationLink(destination: IngredientView(ingredient: $kitchen.ingredients[index])) {
                                    Text(kitchen.ingredients[index].getName())
                                }
                                
                            }
                            .onDelete(perform: deleteIngredient)
                        }
                    }
                    
                }
            }
            
            .navigationTitle(kitchen.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Add a product") {
                            navigateTo = AnyView(AddProductView(presentView: $isAddViewActive, kitchen: kitchen))
//                            self.viewState = .addProduct
                            isAddViewActive = true
                        }
                        Button("Add an ingredient"){
                            navigateTo = AnyView(AddIngredientView(presentView: $isAddViewActive, kitchen: kitchen))
//                            self.viewState = .addIngredient
                            isAddViewActive = true
                        }
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    .background(

                        NavigationLink(destination: navigateTo.id(UUID()), isActive: $isAddViewActive){
                            EmptyView()

                        }

                    )
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        ForEach(kitchens.kitchens.indices){ index in
                            Button(kitchens.kitchens[index].name){
                                kitchenIndex.index = index
                            }
                        }
                        Button("Add a kitchen") {
//                            navigateTo = AnyView(AddProductView(presentView: $isAddViewActive))
//                            isAddViewActive = true
                        }

                    } label: {
                        Image(systemName: "plus")
                    }
//                    HStack{
//                        //Image(systemName: "backarrow")
//                        Button("Back"){
//                            kitchenIndex.index = 1
//                        }
//                    }
                }
                
                
                
            }
            
        }
        
   }
}

struct KitchenView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenView(kitchen: Kitchen(), viewState: .constant(ViewState.kitchen))
    }
}
