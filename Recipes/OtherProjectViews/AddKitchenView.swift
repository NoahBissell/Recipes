//
//  AddKitchenView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 4/23/22.
//

import SwiftUI

struct AddKitchenView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @State var kitchenName : String
    @StateObject var kitchen : Kitchen = Kitchen()
    @EnvironmentObject var userInfo : UserInfo
    @EnvironmentObject var kitchens : Kitchens
    @State var isPresentingSheet : Bool = false
    @Binding var presentView : Bool
    
    var body: some View {
        VStack {
            List {
//                Text(kitchen.name)
//                    .font(.title)
//                    .fontWeight(.bold)
                HStack {
                    Text("Name:")
                        .fontWeight(.thin)
                    TextField("Kitchen name", text: $kitchen.name)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Allergens")) {
                    Toggle("Gluten-free", isOn: $kitchen.glutenFree)
                }
                
                Section(header: Text("Members")) {
                    Button("Invite member") {
                        isPresentingSheet = true
                    }
                    .sheet(isPresented: $isPresentingSheet, content: {
                            AddMemberView(kitchen: kitchen)}
                    )
                }
            }
            .background(Color.background)
        }
        .navigationTitle(kitchen.name)
        
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button (action: {
                    kitchens.kitchens.append(kitchen)
                    userInfo.kitchenIds.append(kitchen.kitchenId!)
//                    kitchen.ownerId = userInfo.userId
                    kitchen.owner = userInfo
                    FirebaseFunctions.updateKitchen(userInfo: userInfo, kitchen: kitchen) { completed in
                        //
                    }
                    FirebaseFunctions.updateUser(userInfo: userInfo)
                    presentView = false
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Create Kitchen")
                })
            }
        })
    }
}

struct AddKitchenView_Previews: PreviewProvider {
    static var previews: some View {
        AddKitchenView(presentView: .constant(true))
    }
}
