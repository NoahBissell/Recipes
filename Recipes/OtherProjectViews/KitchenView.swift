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
    //    @EnvironmentObject var currentKitchen : Kitchen
    @ObservedObject var kitchen : Kitchen
    @State var isAddViewActive = false
    @State var navigateTo : AnyView?
    @State var isPresentingSheet = false
    
    @Binding var viewState : ViewState
    
    func deleteProduct(at offsets: IndexSet){
        kitchen.removeProduct(at: offsets)
        FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
            //
        }
    }
    func deleteIngredient(at offsets: IndexSet){
        kitchen.removeIngredient(at: offsets)
        FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
            //
        }
    }
    func deleteMember(at offsets: IndexSet) {
        kitchen.members.remove(atOffsets: offsets)
        FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
            //
        }
    }
    
    var body : some View {
        NavigationView {
            VStack{
                //                Menu {
                //                    ForEach(kitchens.kitchens.indices){ index in
                //                        Button(kitchens.kitchens[index].name){
                //                            kitchenIndex.index = index
                ////                                currentKitchen = kitchen
                //                        }
                //                    }
                //                    HStack {
                //                        Button("Add a kitchen") {
                //                            navigateTo = AnyView(AddKitchenView(presentView: $isAddViewActive))
                //                            isAddViewActive = true
                //                        }
                //                    }
                //
                //                } label: {
                //                    Text(kitchen.name)
                //                        .font(.title)
                //                        .fontWeight(.bold)
                //                        .accentColor(.black)
                //                }
                //                Button("Upload kitchen to firebase"){
                //                    FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                //                        if(completed) {
                //                            print("worked?")
                //                        }
                //                        else {
                //                            print("didn't work?")
                //                        }
                //                    }
                //                    FirebaseFunctions.addKitchenId(kitchenIds: [kitchen.kitchenId!]) { completed in
                //                        if(completed) {
                //                            print("worked?")
                //                        }
                //                        else {
                //                            print("didn't work?")
                //                        }
                //                    }
                //
                //                }
                //                Button("Download kitchens from firebase") {
                //                    FirebaseFunctions.getKitchensData(userInfo, kitchens)
                //                }
                
                Form{
                    Section(header: Text("All products")){
                        //                        List {
                        ForEach(kitchen.products.indices, id: \.self){ index in
                            NavigationLink(
                                destination: ProductView(product: $kitchen.products[index], kitchen: kitchen),
                                
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
                                NavigationLink(destination: IngredientView(kitchen: kitchen, ingredient: $kitchen.ingredients[index])) {
                                    Text(kitchen.ingredients[index].getName())
                                }
                                
                            }
                            .onDelete(perform: deleteIngredient)
                        }
                    }
                    
                    //                    Divider()
                    
                    if(kitchen.owner.userId == userInfo.userId) {
                        Section(header: Text("Members")) {
                            ForEach(kitchen.members) { member in
                                if(member.userId == kitchen.owner.userId) {
                                    Text("\(member.name) (Owner)")
                                        .fontWeight(.bold)
                                }
                                else {
                                    Text(member.name)
                                }
                            }
                            .onDelete(perform: deleteMember)
                            
                            
                            Button("Invite member") {
                                isPresentingSheet = true
                            }
                            .sheet(isPresented: $isPresentingSheet, content: {
                                AddMemberView(kitchen: kitchen)}
                            )
                        }
                    }
                    else {
                        Section(header: Text("Members")) {
                            ForEach(kitchen.members) { member in
                                if(member.userId == userInfo.userId) {
                                    Text(member.name)
                                        .fontWeight(.bold)
                                }
                                else if(member.userId == kitchen.owner.userId) {
                                    Text("\(member.name) (Owner)")
                                }
                                else {
                                    Text(member.name)
                                }
                            }
                            
                            Button("Invite member") {
                                isPresentingSheet = true
                            }
                            .sheet(isPresented: $isPresentingSheet, content: {
                                AddMemberView(kitchen: kitchen)}
                            )
                        }
                    }
                    
                }
                .background(Color.background)
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
                                //                                currentKitchen = kitchen
                            }
                        }
                        
                        Button("Add a kitchen") {
                            navigateTo = AnyView(AddKitchenView(presentView: $isAddViewActive))
                            isAddViewActive = true
                        }
                        
                        
                    } label: {
                        Image(systemName: "rectangle.grid.1x2")
                    }
                    
                }
                
                
                
            }
            
            
        }
        .background(NavigationConfigurator { nc in
                        nc.navigationBar.barTintColor = .blue
                        nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                    })
        
    }
        
}

struct KitchenView_Previews: PreviewProvider {
    static var previews: some View {
        KitchenView(kitchen: Kitchen(), viewState: .constant(ViewState.kitchen))
            .environmentObject(Kitchens())
            .environmentObject(UserInfo())
            .environmentObject(KitchenIndex())
    }
}
