//
//  Kitchen.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 3/1/22.
//

import Foundation

class Kitchen : ObservableObject {
	
    var ownerId : UUID
    var memberIds : [UUID]
    
	@Published var products : [Product]
	@Published var ingredients : [Ingredient]
	@Published var recipes : [Recipe]
	
    init(products : [Product] = [Product](), recipes : [Recipe] = [Recipe](), ingredients : [Ingredient] = [Ingredient](), ownerId : UUID, memberIds : [UUID] = [UUID]()){
		self.products = products
		self.recipes = recipes
		self.ingredients = ingredients
        self.ownerId = ownerId
        self.memberIds = [ownerId]
        self.memberIds.append(contentsOf: memberIds)
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

class Kitchens : ObservableObject {
    var kitchens : [Kitchen]
    init(kitchens : [Kitchen]){
        self.kitchens = kitchens
    }
    init(){
        self.kitchens = [Kitchen]()
    }
}
