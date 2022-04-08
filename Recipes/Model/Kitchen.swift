//
//  Kitchen.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 3/1/22.
//

import Foundation
import Combine

class KitchenIndex : ObservableObject {
    @Published var index : Int
    
    init(index : Int){
        self.index = index
    }
    init(){
        self.index = 0
    }
}

class Kitchen : ObservableObject, Identifiable {
    var kitchenId : UUID
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
	
    init(products : [Product] = [Product](), recipes : [Recipe] = [Recipe](), ingredients : [Ingredient] = [Ingredient](), name : String = "Untitled", ownerId : UUID = UUID(), memberIds : [UUID] = [UUID](), kitchenId : UUID = UUID()){
		self.products = products
		self.recipes = recipes
		self.ingredients = ingredients
        self.ownerId = ownerId
        self.name = name
        self.memberIds = [ownerId]
        self.memberIds.append(contentsOf: memberIds)
        self.kitchenId = kitchenId
	}
    
    func copy(with zone: NSZone? = nil) -> Any {
            let copy = Kitchen(products: products, recipes: recipes, ingredients: ingredients, name: name, ownerId: ownerId, memberIds: memberIds)
            return copy
    }
    
    func copyElementsFrom(kitchen : Kitchen){
        self.products = kitchen.products
        self.ingredients = kitchen.ingredients
        self.recipes = kitchen.recipes
        self.ownerId = kitchen.ownerId
        self.memberIds = kitchen.memberIds
        self.name = kitchen.name
    }
	
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
