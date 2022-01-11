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
        guard let url = URL(string:"https://newsapi.org/v2/everything?q=bitcoin&language=fr&apiKey=98731d197e294c8a8ba9ceebcb251401") else {return}
        
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

struct Response: Codable{
    var totalResults: Int = 0
    var articles : [Article] = [Article]()
}

struct Article : Codable{
    var title : String?
    var url : URL?
    var urlToImage : URL?
}
extension Article: Identifiable{
    var id: String {return title!}
}


class FetchRecipe: ObservableObject {
    @Published var recipes = Recipe()
    init(){
        guard let url = URL(string:"https://newsapi.org/v2/everything?q=bitcoin&language=fr&apiKey=98731d197e294c8a8ba9ceebcb251401") else {return}
        
        URLSession.shared.dataTask(with: url) { (data, recipe, errors) in
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
    var totalResults: Int = 0
}

