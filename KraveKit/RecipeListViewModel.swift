//
//  RecipeListView.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import Foundation

struct Meal: Hashable , Codable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct MealResponse: Codable{
    let meals: [Meal]
}

//Refactor for async/await
class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var error: Error?

    func getDesserts() {
    
        error = nil

        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            self.error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }

        URLSession.shared.dataTask(with: url){data , response , error in
            guard let data = data , error == nil else{return}
            
            let decoder = JSONDecoder()
            if let mealResponse = try? decoder.decode(MealResponse.self, from: data){
                DispatchQueue.main.async{
                    self.meals = mealResponse.meals
                }
            }
        }.resume()
           
    }
}





