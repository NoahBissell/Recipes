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
    @Published var owner : UserInfo
    @Published var members : [UserInfo]
    @Published var name : String
    @Published var glutenFree : Bool = false
    
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
    
    @Published var mealCalendar: MealCalendar
	
    init(products : [Product] = [Product](), recipes : [Recipe] = [Recipe](), ingredients : [Ingredient] = [Ingredient](), name : String = "Untitled", owner : UserInfo = UserInfo(), kitchenId : String = UUID().uuidString, mealCalendar: MealCalendar = MealCalendar()){
		self.products = products
		self.recipes = recipes
		self.ingredients = ingredients
        self.owner = owner
        self.name = name
        self.members = [owner]
//        self.members.append(contentsOf: members)
        self.kitchenId = kitchenId
        self.mealCalendar = mealCalendar
	}
    
    
    
    enum CodingKeys: CodingKey {
        case products
        case ingredients
        case recipes
        case kitchenId
        case owner
        case name
        case members
        case glutenFree
        case mealCalendar
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        products = try container.decode([Product].self, forKey: .products)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        recipes = try container.decode([Recipe].self, forKey: .recipes)
        kitchenId = try container.decode(String?.self, forKey: .kitchenId)
        owner = try container.decode(UserInfo.self, forKey: .owner)
        members = try container.decode([UserInfo].self, forKey: .members)
        name = try container.decode(String.self, forKey: .name)
        glutenFree = try container.decode(Bool.self, forKey: .glutenFree)
        mealCalendar = try container.decode(MealCalendar.self, forKey: .mealCalendar)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(products, forKey: .products)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(recipes, forKey: .recipes)
        try container.encode(kitchenId, forKey: .kitchenId)
        try container.encode(owner, forKey: .owner)
        try container.encode(members, forKey: .members)
        try container.encode(name, forKey: .name)
        try container.encode(glutenFree, forKey: .glutenFree)
        try container.encode(mealCalendar, forKey: .mealCalendar)
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
    init(userInfo: UserInfo) {
        self.kitchens = [Kitchen]()
        FirebaseFunctions.getKitchensData(userInfo, self)
    }
    func initialize(userInfo: UserInfo) {
        self.kitchens = [Kitchen]()
        FirebaseFunctions.getKitchensData(userInfo, self)
    }
}
