//
//  Kitchen.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 3/1/22.
//

import Foundation
import Combine
import FirebaseFirestoreSwift

class KitchenIndex : ObservableObject {
    @Published var index : Int
    
    init(index : Int){
        self.index = index
    }
    init(){
        self.index = 0
    }
}

class Kitchen : ObservableObject, Identifiable, Codable {
    @DocumentID var kitchenId : String?
    
//    var kitchenId : UUID
    var ownerId : UUID
    var memberIds : [UUID]
    var name : String
    @Published var products : [Product]
//    {
//        willSet {
//            objectWillChange.send()
//        }
//    }
	@Published var ingredients : [Ingredient]
//    {
//        willSet {
//            objectWillChange.send()
//        }
//    }
	@Published var recipes : [Recipe]
//    {
//        willSet {
//            objectWillChange.send()
//        }
//    }
	
    init(products : [Product] = [Product](), recipes : [Recipe] = [Recipe](), ingredients : [Ingredient] = [Ingredient](), name : String = "Untitled", ownerId : UUID = UUID(), kitchenId : String = UUID().uuidString){
		self.products = products
		self.recipes = recipes
		self.ingredients = ingredients
        self.ownerId = ownerId
        self.name = name
        self.memberIds = [ownerId]
        self.memberIds.append(contentsOf: memberIds)
        self.kitchenId = kitchenId
	}
    
    enum CodingKeys: CodingKey {
        case products
        case ingredients
        case recipes
        case kitchenId
        case ownerId
        case name
        case memberIds
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        recipes = try container.decode([Recipe].self, forKey: .recipes)
        kitchenId = try container.decode(String?.self, forKey: .kitchenId)
        ownerId = try container.decode(UUID.self, forKey: .ownerId)
        memberIds = try container.decode([UUID].self, forKey: .memberIds)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(recipes, forKey: .recipes)
        try container.encode(kitchenId, forKey: .kitchenId)
        try container.encode(ownerId, forKey: .ownerId)
        try container.encode(memberIds, forKey: .memberIds)
        try container.encode(name, forKey: .name)
        
    }
    
//    func copy(with zone: NSZone? = nil) -> Any {
//            let copy = Kitchen(products: products, recipes: recipes, ingredients: ingredients, name: name, ownerId: ownerId, memberIds: memberIds)
//            return copy
//    }
//
//    func copyElementsFrom(kitchen : Kitchen){
//        self.products = kitchen.products
//        self.ingredients = kitchen.ingredients
//        self.recipes = kitchen.recipes
//        self.ownerId = kitchen.ownerId
//        self.memberIds = kitchen.memberIds
//        self.name = kitchen.name
//    }
	
	// Use this function when initializing a new product in order to make sure storedQuantity is always 1
	func createProduct(product : Product) -> Product {
		var returnProduct = product
		returnProduct.storedQuantity = 1
		return returnProduct
	}
	func addProduct(product : Product){
		products.append(product)
	}
	func removeProduct(at offsets: IndexSet){
		products.remove(atOffsets: offsets)
	}
	
	func addIngredient(ingredient : Ingredient){
		ingredients.append(ingredient)
	}
	func removeIngredient(at offsets: IndexSet){
		ingredients.remove(atOffsets: offsets)
	}
	
	func addRecipe(recipe : Recipe){
		recipes.append(recipe)
	}
	func removeRecipe(at offsets: IndexSet){
		recipes.remove(atOffsets: offsets)
	}
		
	//    func addProducts(product: Product, quantity : Int){
	//        if let num = products[product]{
	//            products.updateValue(num + 1, forKey: product)
	//        }
	//        else{
	//            products[product] = 0
	//        }
	//    }
    

}

class Kitchens : ObservableObject, Identifiable {
    @Published var kitchens : [Kitchen]
    init(kitchens : [Kitchen]){
        self.kitchens = kitchens
    }
    init(){
        self.kitchens = [Kitchen]()
    }
}
