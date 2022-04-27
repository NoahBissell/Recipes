//
//  AddMemberView.swift
//  Recipes
//
//  Created by Noah Bissell (student LM) on 4/23/22.
//

import SwiftUI

struct AddMemberView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var email : String = ""
    @Binding var kitchen : Kitchen
    @State var users : [UserInfo] = [UserInfo]()
    @State var isPresentingAlert = false
    
    func nothing(){}
    func addMember(user: UserInfo) ->() {
        //
    }
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .onChange(of: email, perform: { value in
                    print("searching \(users.count)")
                    FirebaseFunctions.searchUsers(email: email) { returnedUsers in
                        self.users.removeAll()
                        self.users.append(contentsOf: returnedUsers)
                    }
                })
            List {
                ForEach(users) { user in
                    Button(user.email) {
                        isPresentingAlert = true
//                        if let id = user.userId
//                        {
                        
                        kitchen.members.append(user)
//                        }
//                        else {
//                            print("AddMemberView 42")
//                        }
                        FirebaseFunctions.addKitchenId(userInfo: user, kitchenIds: [kitchen.kitchenId!]) { completed in
                            //
                        }
                    }
//                    .alert(isPresented: $isPresentingAlert, content: {
//                        Alert(title: Text("Add this user to your kitchen?"), primaryButton: Alert.Button.default(
//                            Text("Yes"),
//                            action: addMember
//                        ), secondaryButton: Alert.Button.destructive(
//                            Text("Cancel"),
//                            action: nothing))
//                    })
                }
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Search") {
                    // TODO: add firebase function for sending invitations
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        })
    }
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView(kitchen: .constant(Kitchen()))
    }
}
