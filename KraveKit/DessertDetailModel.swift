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
    let strArea: String
    let strInstructions: String
    
    //strIngredient(i-n) if not null  + strMeasure(i-n) if not null formatted on the view
    let ingredients : [String]
    let measures: [String]
    
    //CodingKeys for parsing the null values from JSON
    enum CodingKeys: String, CodingKey {
           case idMeal
           case strMeal
           case strArea
           case strInstructions
           case strMealThumb
           case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
           case strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
           case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15
           case strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
           case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
           case strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
           case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15
           case strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
       }
    
    //init method for decoding the information
    init (from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //These values were not null and only contained one entry
        idMeal = try container.decode(String.self , forKey: .idMeal)
        strMeal = try container.decode(String.self , forKey: .strMeal)
        strMealThumb = try container.decode(String.self , forKey: .strMealThumb)
        strInstructions = try container.decode(String.self , forKey: .strInstructions)
        strArea = try container.decode(String.self, forKey: .strArea)
        
        //for multiple entries iterate over the common prefixes and add them to the arrays if present
        ingredients = try (1...20).compactMap{index in
            let key = CodingKeys(rawValue: "strIngredient\(index)")
            return try container.decodeIfPresent(String.self , forKey: key!)
        }
        
        measures = try (1...20).compactMap{index in
            let key = CodingKeys(rawValue: "strMeasure\(index)")
            return try container.decodeIfPresent(String.self , forKey: key!)
        }
    }
    
    
    func encode(to encoder: Encoder)throws{
        var container = encoder.container(keyedBy : CodingKeys.self)
        
        try container.encode(idMeal , forKey: .idMeal)
        try container.encode(strMeal , forKey: .strMeal)
        try container.encode(strMealThumb , forKey: .strMealThumb)
        try container.encode(strInstructions , forKey: .strInstructions)
        try container.encode(strArea , forKey: .strArea)
        
        for(index , ingredient) in ingredients.enumerated(){
            let key = CodingKeys(rawValue: "strIngredient\(index + 1)")
            try container.encodeIfPresent(ingredient, forKey: key!)
        }
        
        for(index , measure) in measures.enumerated(){
            let key = CodingKeys(rawValue: "strMeasure\(index + 1)")
            try container.encodeIfPresent(measure, forKey: key!)
        }
        
    }
}

struct DetailResponse: Codable{
    let meals : [DessertDetail]
}


//Refactor to Async /Await 
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
                print(detailResponse.meals)
            }
          }
        }.resume()
        
    }
    
}
