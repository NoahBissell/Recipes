//
//  Kitchen.swift
//  Recipes
//
//  Created by Eric Nie (student LM) on 3/1/22.
//

import Foundation

class Kitchen : ObservableObject {
	
	@Published var products : [Product]
	@Published var ingredients : [Ingredient]
	@Published var recipes : [Recipe]
	
	init(products : [Product] = [Product](), recipes : [Recipe] = [Recipe](), ingredients : [Ingredient] = [Ingredient]()){
		self.products = products
		self.recipes = recipes
		self.ingredients = ingredients
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
