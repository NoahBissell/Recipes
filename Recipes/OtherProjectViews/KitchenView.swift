//
//  KitchenView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell on 1/22/22.
//

import SwiftUI

struct KitchenView: View {
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @State var isAddViewActive = false
    @State var navigateTo : AnyView?
    
    func deleteProduct(at offsets: IndexSet){
        kitchens.kitchens[kitchenIndex.index].removeProduct(at: offsets)
    }
    func deleteIngredient(at offsets: IndexSet){
        kitchens.kitchens[kitchenIndex.index].removeIngredient(at: offsets)
    }
    
    var body : some View {
        NavigationView {
            VStack{
               
                Form{
                    Section(header: Text("All products")){
//                        List {
                        ForEach(kitchens.kitchens[kitchenIndex.index].products.indices, id: \.self){ index in
                                NavigationLink(
                                    destination: ProductView(product: $kitchens.kitchens[kitchenIndex.index].products[index]).id(UUID()),
                                    
                                    label: {
                                        ProductDetail(product: kitchens.kitchens[kitchenIndex.index].products[index])
                                    })
                                    
                            }
                            .onDelete(perform: deleteProduct)
//                        }
                    }
                    Section(header: Text("Ingredients")){
                        List {
                            ForEach(kitchens.kitchens[kitchenIndex.index].ingredients.indices, id: \.self){ index in
                                NavigationLink(destination: IngredientView(ingredient: $kitchens.kitchens[kitchenIndex.index].ingredients[index])) {
                                    Text(kitchens.kitchens[kitchenIndex.index].ingredients[index].getName())
                                }
                                
                            }
                            .onDelete(perform: deleteIngredient)
                        }
                    }
                    
                }
            }
            
            .navigationTitle("My Kitchen")
            .toolbar {
                Menu {
                    Button("Add a product") {
                        navigateTo = AnyView(AddProductView(presentView: $isAddViewActive))
                        isAddViewActive = true
                    }
                    Button("Add an ingredient"){
                        navigateTo = AnyView(AddIngredientView(presentView: $isAddViewActive))
                        isAddViewActive = true
                    }
                    
                } label: {
                    Image(systemName: "plus")
                }
                .background(
                    
                    NavigationLink(destination: navigateTo, isActive: $isAddViewActive){
                        EmptyView()
                        
                    }
                    
                )
                
                Menu {
                    ForEach(kitchens.kitchens.indices){ index in
                        Button(kitchens.kitchens[index].name){
                            kitchenIndex.index = index
                        }
                    }
                    Button("Add a kitchen") {
                        navigateTo = AnyView(AddProductView(presentView: $isAddViewActive))
                        isAddViewActive = true
                    }
                    
                } label: {
                    Image(systemName: "plus")
                }
                
                
            }
            
        }
        
    }
}

struct KitchenView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenView()
    }
}
