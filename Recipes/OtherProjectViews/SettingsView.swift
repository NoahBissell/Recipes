//
//  SettingsView.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell (student LM) on 2/28/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userInfo : UserInfo
    @EnvironmentObject var kitchens : Kitchens
    @EnvironmentObject var kitchenIndex : KitchenIndex
    @State private var showSheet = false
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.background)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Image(uiImage: userInfo.image)
                        .resizable()
                        .frame(width:200, height: 200)
                        .aspectRatio(contentMode: .fill)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding()
//                    VStack {
                    HStack {
                        Image(systemName: "person")
                            .padding()
                        TextField("name", text: $userInfo.name)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                            .padding()
                            .disableAutocorrection(true)
                            .onChange(of: userInfo.name, perform: { newValue in
                                print("updating?")
                                FirebaseFunctions.updateUser(userInfo: userInfo)
                            })
                            .padding()
                    }
                    .background(Color.foreground)
                    .frame(width: geo.size.width * 0.9)
                    .cornerRadius(20)
                    .padding()
                    
                    Button(
                        action: {
                            showSheet = true
                        }, label: {
                            Text("change image")
                                .fontWeight(.thin)
                        })
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .padding()
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonText)
                        .cornerRadius(30)
                    
                        .padding()
                    Button(
                        action: {
                            FirebaseFunctions.signOut(userInfo)
                        }, label: {
                            Text("sign out")
                                .fontWeight(.thin)
                        })
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .padding()
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonText)
                        .cornerRadius(30)
                    
                        .padding()
//                }
                
                }
            }
            
            .sheet(isPresented: $showSheet, onDismiss: {
                FirebaseFunctions.uploadPicture(image: userInfo.image) { result in
                    //
                }
            }, content: {
                ImagePicker(selectedImage: $userInfo.image)
            })
            
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserInfo())
            .environmentObject(Kitchens())
            .environmentObject(KitchenIndex())
    }
}
