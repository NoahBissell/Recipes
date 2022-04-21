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
    var userId : UUID
    var kitchenIds : [String]
    @Published var image : UIImage = UIImage(named: "user.png")!
    @Published var loggedIn : Bool
    @Published var searchSettings : SearchSettings


    
    init(name : String = "", email : String = "", password : String = "", searchSettings : SearchSettings = SearchSettings(), loggedIn : Bool = false) {
        self.name = name
        self.email = email
        self.password = password
        self.userId = UUID()
        self.kitchenIds = [String]()
        self.loggedIn = loggedIn
        self.searchSettings = searchSettings

        FirebaseFunctions.getUserInfo(self)
    }
}
