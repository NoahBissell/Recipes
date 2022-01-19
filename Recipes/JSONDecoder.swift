//
//  JSONDecoder.swift
//  Recipes
//
//  Created by George Lauri (student LM) on 1/10/22.
//

import Foundation

class FetchData: ObservableObject {
    @Published var responses = Response()
    
    init(){
        
    }
    func fetchRecipes(diet : String = "vegan") -> Response{
        guard let url = URL(string: (diet == "gluten" ? "https://api.spoonacular.com/recipes/complexSearch?apiKey=b216ab7db3b144f6af3d732e19080f8a&diet=\(diet)":"https://api.spoonacular.com/recipes/complexSearch?apiKey=b216ab7db3b144f6af3d732e19080f8a&intolerances=\(diet)")) else {return Response()}
        // https://api.spoonacular.com/recipes/complexSearch?apiKey=dc7b6320294946cc8ef2be70d8e98db3&diet=vegan
        
        URLSession.shared.dataTask(with: url) { (data, response, errors) in
            guard let data = data else {return}
            
            //guard let dataAsString = String(data: data, encoding: .utf8) else {return}
           // print(dataAsString)
            let decoder = JSONDecoder()
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.responses = response
                }
            }
            
            
            
        }.resume()
        return responses
    }
    
}

struct Response: Codable{
    var results : [Result] = [Result]()
}

struct Result : Codable, Identifiable{
    var title : String?
    var image : URL?
    var id: Int
}


//extension Article: Identifiable{
//    var id: String {return title!}
//}


class FetchRecipe: ObservableObject {
    @Published var recipes = Recipe()
    init(name : Int = 716429){
        guard let url = URL(string:"https://api.spoonacular.com/recipes/\(name)/information?apiKey=b216ab7db3b144f6af3d732e19080f8a&includeNutrition=true") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, errors) in
            guard let data = data else {return}
            
            //guard let dataAsString = String(data: data, encoding: .utf8) else {return}
           // print(dataAsString)
            let decoder = JSONDecoder()
            if let recipe = try? decoder.decode(Recipe.self, from: data) {
                DispatchQueue.main.async {
                    self.recipes = recipe
                }
            }
            
            
            
        }.resume()
    }
    
}

struct Recipe: Codable{
    var extendedIngredients: [Ingredient] = [Ingredient]()
    var id: Int?
    var title: String?
    var readyInMinutes: Int?
    var servings: Int?
    var image: URL?
    var summary: String?
    var instructions: String?
    var sourceUrl: URL?
    var vegetarian: Bool?
    var vegan: Bool?
    var glutenFree: Bool?
    
}
struct Ingredient: Codable{
    var name: String?
}

