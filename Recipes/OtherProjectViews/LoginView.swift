//
//  LoginView.swift
//  SlowmoGraham
//
//  Created by Noah Bissell (student LM) on 2/2/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userInfo : UserInfo
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.white)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                HStack {
                    Image(systemName: "mail")
                    TextField("email", text: $userInfo.email)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding()
                }
                HStack {
                    Image(systemName: "lock")
                    SecureField("password", text: $userInfo.password)
                        .padding()
                }
                Button("forgot password") {
                    FirebaseFunctions.forgotPassword(email: userInfo.email) { success in
                        
                    }
                }
//                .foregroundColor(Color.buttonBackground)
                .padding()
                    Spacer()
                Button("create account with email") {
                    FirebaseFunctions.authenticate(email: userInfo.email, password: userInfo.password) { success in
                        if success {
                            userInfo.loggedIn = true
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
//                .background(Color.buttonBackground)
//                .foregroundColor(Color.buttonText)
                .cornerRadius(30)
                Button("Sign In") {
                    FirebaseFunctions.login(email: userInfo.email, password: userInfo.password) { success in
                        if success {
                            userInfo.loggedIn = true
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
                .cornerRadius(30)
                .padding()
                Button("Auto-Log") {
                    FirebaseFunctions.login(userInfo)
                    FirebaseFunctions.login(email: userInfo.email, password: userInfo.password) { success in
                        if success {
                            userInfo.loggedIn = true
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                .padding()
                .cornerRadius(30)
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserInfo())
    }
}
