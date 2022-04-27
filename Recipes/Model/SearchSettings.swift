//
//  SearchSettings.swift
//  Recipes
//
//  Created by George Lauri (student LM) on 3/18/22.
//
import FirebaseFirestoreSwift
import SwiftUI
enum Diet : String, CaseIterable, Identifiable, Codable {
    case none
    case vegan
    case vegetarian
    case pescetarian
    case ketogenic
    case paleo
    var id : String { self.rawValue}
}
class SearchSettings : Codable{
    @DocumentID var id : String?
    var vegan : Bool
    var vegetarian : Bool
    var gluten : Bool
    var dairy : Bool
    var diet : Diet


    init(vegan : Bool = false, vegetarian: Bool = false, diet: Diet = .none, gluten : Bool = false, dairy : Bool = false){
        self.vegan = vegan
        self.vegetarian = vegetarian
        self.diet = diet
        self.gluten = gluten
        self.dairy = dairy
        

    }
    
    enum CodingKeys: CodingKey {
        case vegan
        case vegetarian
        case gluten
        case dairy
        case diet
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vegan = try container.decode(Bool.self, forKey: .vegan)
        vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        gluten = try container.decode(Bool.self, forKey: .gluten)
        dairy = try container.decode(Bool.self, forKey: .dairy)
        diet = try container.decode(Diet.self, forKey: .diet)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(vegan, forKey: .vegan)
        try container.encode(vegetarian, forKey: .vegetarian)
        try container.encode(gluten, forKey: .gluten)
        try container.encode(dairy, forKey: .dairy)
        try container.encode(diet, forKey: .diet)
    }
    
}
