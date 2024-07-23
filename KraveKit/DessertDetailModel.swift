//
//  DessertDetailModel.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import Foundation

struct DessertDetail: Hashable , Codable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    //Area of origin
    let strArea: String
    let strInstructions: String
    
    //strIngredient(i-n) if not null  + strMeasure(i-n) if not null formatted on the view
}

struct DetailResponse: Codable{
    let meals : [DessertDetail]
}

class DessertDetailModel: ObservableObject{
    @Published var dessert: DessertDetail?
    @Published var error: Error?
    
    func getDessertDetails(idMeal: String){
        
        error = nil
        
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        guard let url = URL(string: urlString) else {
            self.error = NSError(domain: "", code: -1 ,userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            return
        }
        
        URLSession.shared.dataTask(with: url){data , response , error in
            guard let data = data , error == nil else {return}
            
            let decoder = JSONDecoder()
            if let detailResponse = try? decoder.decode(DetailResponse.self, from: data), let dessert = detailResponse.meals.first{DispatchQueue.main.async{
                self.dessert = dessert
            }
          }
        }.resume()
        
    }
    
}
