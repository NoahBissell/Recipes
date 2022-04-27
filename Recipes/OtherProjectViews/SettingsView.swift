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
                HStack {
                    Image(systemName: "person")
                    TextField("name", text: $userInfo.name)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                        .disableAutocorrection(true)
                        .onChange(of: userInfo.name, perform: { _ in
                            FirebaseFunctions.addUsername(username: userInfo.name) { _ in}
                        })
                }
                
                Button("change image") {
                    showSheet = true
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
                .background(Color.buttonBackground)
                .foregroundColor(Color.buttonText)
                .cornerRadius(30)
                Button("sign out") {
                    kitchenIndex.index = 0
                    kitchens.kitchens.removeAll()
                    
                    FirebaseFunctions.signOut(userInfo)
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
                .background(Color.buttonBackground)
                .foregroundColor(Color.buttonText)
                .cornerRadius(30)
                
                .padding()
                }
        }
        .sheet(isPresented: $showSheet, onDismiss: {
            FirebaseFunctions.uploadPicture(image: userInfo.image) { result in
                //
            }
        }, content: {
//            ImagePicker(selectedImage: $userInfo.image)
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserInfo())
            .environmentObject(Kitchens())
            .environmentObject(KitchenIndex())
    }
}
