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
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .foregroundColor(Color.background)
                    .edgesIgnoringSafeArea(.all)
                //                .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                //                .cornerRadius(50)
                VStack {
                    ZStack {
                        Image("dysh icon")
                            .resizable()
                        Text("Dysh")
                        .fontWeight(.medium)
                        .font(.title)
                        .foregroundColor(Color.black)
                    }
                    //                    .foregroundColor(.white)
                    
                    //                    .siz
                    //                    .frame(width:390, height: 200)
                        .aspectRatio(contentMode: .fit)
//                        .aspec
                    //                    .background(Color.white)
                    //                    .clipShape(Circle())
                    
                    VStack {
                        HStack {
                            Image(systemName: "mail")
                            TextField("email", text: $userInfo.email)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding()
                                .disableAutocorrection(true)
                           
                        }
                        .padding()
                        Divider()
                        HStack {
                            Image(systemName: "lock")
                            SecureField("password", text: $userInfo.password)
                                .padding()
                        }
                        .padding()
                    }
                    .background(Color.foreground)
                    .frame(width: geo.size.width * 0.9)
                    .cornerRadius(30)
                    Button(action: {
                        FirebaseFunctions.forgotPassword(email: userInfo.email) { success in
                            
                        }
                    }, label: {
                        Text("forgot password?")
                        //                        .fontWeight(.thin)
                        //                        .font(.)
                    })
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .padding()
                    //                .background(Color.buttonBackground)
                        .foregroundColor(Color.blue)
                        .cornerRadius(30)
                    
                    
                    
                    
                    //                    Spacer()
                    
                    Button(action: {
                        FirebaseFunctions.authenticate(email: userInfo.email, password: userInfo.password) { success in
                            if success {
                                userInfo.loggedIn = true
                                FirebaseFunctions.updateUser(userInfo: userInfo)
                                print("one")
                            }
                            
                        }
                    }, label: {
                        Text("create account with email")
                            .fontWeight(.thin)
                        //                        .font(.)
                    })
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .padding()
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonText)
                        .cornerRadius(30)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                    Button(action: {
                        FirebaseFunctions.login(email: userInfo.email, password: userInfo.password) { success in
                            if success {
                                userInfo.loggedIn = true
                                //                            FirebaseFunctions.addUser(userInfo: userInfo)
                                print("two")
                            }
                            
                            
                        }
                    }, label: {
                        Text("log in")
                            .fontWeight(.thin)
                        //                        .font(.)
                    })
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .padding()
                        .background(Color.buttonBackground)
                        .foregroundColor(Color.buttonText)
                        .cornerRadius(30)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    //
                    
                    //                Button("Auto-Log") {
                    //                    FirebaseFunctions.login(userInfo)
                    //                    FirebaseFunctions.login(email: userInfo.email, password: userInfo.password) { success in
                    //                        if success {
                    //                            userInfo.loggedIn = true
                    ////                            FirebaseFunctions.addUser(userInfo: userInfo)
                    //                            print("three")
                    //                        }
                    //                    }
                    //
                    //                }
                    //                .frame(width: UIScreen.main.bounds.width - 100)
                    //                .padding()
                    //                .cornerRadius(30)
                    //                .padding()
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserInfo())
    }
}
