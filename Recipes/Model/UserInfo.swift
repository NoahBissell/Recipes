//
//  UserInfo.swift
//  SoftwareDevelopmentProject
//
//  Created by Noah Bissell (student LM) on 2/28/22.
//

import SwiftUI
import FirebaseFirestoreSwift

class UserInfo : ObservableObject, Codable, Identifiable {
    @DocumentID var userId : String?
    @Published var name : String
    @Published var email : String
    @Published var password : String
//    var userId : UUID
    @Published var kitchenIds : [String]
    @Published var image : UIImage = UIImage(named: "user.png")!
    @Published var loggedIn : Bool
    @Published var searchSettings : SearchSettings


    
    init(name : String = "", email : String = "", password : String = "", searchSettings : SearchSettings = SearchSettings(), loggedIn : Bool = false, id : String = UUID().uuidString) {
        self.name = name
        self.email = email
        self.password = password
//        self.userId = UUID()
        self.kitchenIds = [String]()
        self.loggedIn = loggedIn
        self.searchSettings = searchSettings

        FirebaseFunctions.getUserInfo(self) { completed in
            
        }
            
    }
    
    func initialize(completion: @escaping (Bool) -> ()) {
        FirebaseFunctions.getUserInfo(self) { completed in
            if completed {
                completion(true)
            }
        }
    }
    
    enum CodingKeys: CodingKey {
        case name
        case email
        case password
        case userId
        case kitchenIds
        case loggedIn
        case searchSettings
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        userId = try container.decode(String?.self, forKey: .userId)
        kitchenIds = try container.decode([String].self, forKey: .kitchenIds)
//        loggedIn = try container.decode(Bool.self, forKey: .loggedIn)
        loggedIn = false
        searchSettings = try container.decode(SearchSettings.self, forKey: .searchSettings)
//        id = try container.decode(String?.self, forKey: .id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(kitchenIds, forKey: .kitchenIds)
        try container.encode(userId, forKey: .userId)
        try container.encode(loggedIn, forKey: .loggedIn)
        try container.encode(searchSettings, forKey: .searchSettings)
//        try container.encode(id, forKey: .id)
    }
}
