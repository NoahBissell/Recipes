//  JSONDecoder.swift
//  Recipes
//  Created on 1/10/22.
//  Modified on 1/11/22, 1/12/22, 1/18/22, and 1/19/22
//  Author: George Lauri
//  No other contributors to this file
//  decodes JSON such that it can be fed into views
import Foundation
import SwiftUI

//extension Article: Identifiable{
//    var id: String {return title!}
//}

//initially written on 1/10. Modified on 1/18 to allow initializer to be passed a value and to modify the URL to match that value
class FetchRecipe: ObservableObject {
	@Published var recipe = Recipe()
	init(name : Int = 716429){
		guard let url = URL(string:"https://api.spoonacular.com/recipes/\(name)/information?apiKey=be19bc5826a04fed982556734c3056b7&includeNutrition=true") else {return}
		
		URLSession.shared.dataTask(with: url) { (data, response, errors) in
			guard let data = data else {return}
			
			//guard let dataAsString = String(data: data, encoding: .utf8) else {return}
		   // print(dataAsString)
			let decoder = JSONDecoder()
			if let recipe = try? decoder.decode(Recipe.self, from: data) {
				DispatchQueue.main.async {
					self.recipe = recipe
				}
			}
		}.resume()
	}
}

class FetchData: ObservableObject {
    @Published var responses = Response()
    //initially written on 1/10. Modified on 1/18 and 1/19 to allow initializer to be passed a value and so that the Url could be determined with a ternary operator
    init(diet : String = "vegan"){
        guard let url = URL(string: (diet == "gluten" ? "https://api.spoonacular.com/recipes/complexSearch?apiKey=b216ab7db3b144f6af3d732e19080f8a&intolerances=\(diet)":"https://api.spoonacular.com/recipes/complexSearch?apiKey=b216ab7db3b144f6af3d732e19080f8a&diet=\(diet)")) else {return}
        //API keys for reference
        //dc7b6320294946cc8ef2be70d8e98db3
        //be19bc5826a04fed982556734c3056b7
        //b216ab7db3b144f6af3d732e19080f8a
        //6e1210515a994e818b19fb25a2319a23
        //4753c32caf9640faa169ec11b07ad4fd
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
    }
   
}
//Written on 1/10, 1/11, 1/12, not modified since
struct Response: Codable{
    var results : [Result] = [Result]()
}
//Written on 1/10 and 1/11
//Support for identifiable implemented on 1/12
struct Result : Codable, Identifiable{
    var title : String?
    var image : URL?
    var id: Int
}
