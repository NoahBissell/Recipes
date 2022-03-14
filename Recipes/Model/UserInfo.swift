//
//  UserInfo.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell (student LM) on 2/28/22.
//

import SwiftUI

class UserInfo : ObservableObject {
    var name : String
    var email : String
    var password : String
    var diet : Diet
    @Published var image : UIImage = UIImage(named: "user.png")!
    @Published var loggedIn : Bool
    
    init(name : String = "", email : String = "", password : String = "", diet : Diet = .none, loggedIn : Bool = false) {
        self.name = name
        self.email = email
        self.password = password
        self.loggedIn = loggedIn
        self.diet = diet
        
        FirebaseFunctions.getUserInfo(self)
    }
}
