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
    @ObservedObject var kitchen : Kitchen
    @State var users : [UserInfo] = [UserInfo]()
    @State var isPresentingAlert = false
    @State var showNoResults = false
    
    
    func nothing(){}
    func addMember(user: UserInfo) ->() {
        //
    }
    
    var body: some View {
        ZStack {
//            Rectangle()
//                .foregroundColor(Color.background)
//                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        VStack {
            Form {
                Section {
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .onChange(of: email, perform: { value in
                            print("searching \(users.count)")
                            //                            FirebaseFunctions.searchUsers(email: email) { returnedUsers in
                            //                                self.users.removeAll()
                            //                                self.users.append(contentsOf: returnedUsers)
                            //                            }
                        })
//                        .background(Color.foreground)
                    //                        .padding()
                    if(email.count > 0) {
                        Button("Search") {
                            FirebaseFunctions.searchUsers(email: email) { returnedUsers in
                                self.users.removeAll()
                                if(returnedUsers.isEmpty) {
                                    showNoResults = true
                                }
                                else {
                                    showNoResults = false
                                    self.users.append(contentsOf: returnedUsers)
                                }
                            }
                        }
                    }
                }
                
                if(showNoResults) {
                    Text("No users matched your search...")
                        .fontWeight(.thin)
                }
                Section {
                    List {
                        ForEach(users) { user in
                            Button("Add '\(user.name)' as a member") {
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
                                FirebaseFunctions.updateKitchen(userInfo: user, kitchen: kitchen) { completed in
                                    //
                                }
                            }
//                            .background(Color.foreground)
//                            .buttonStyle(PlainButtonStyle())
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
//                    .listRowBackground(Color.foreground)
                }
            
            }
            .background(Color.background)
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
}

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView(kitchen: Kitchen())
    }
}
