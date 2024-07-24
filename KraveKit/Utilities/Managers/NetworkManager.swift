//
//  NetworkManager.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/24/24.
//

import Foundation

final class NetworkManager{
    
    static let shared = NetworkManager()
    
    private let listURL = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    private let detailsBaseURL = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    private init(){}
    
    
    func getDesserts() async throws -> [Meal]{
        
        guard let url =  URL(string: listURL) else {
            throw KraveKitError.invalidURL
        }
        
        let(data , _) = try await URLSession.shared.data(from: url)
        
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(MealResponse.self , from: data).meals
            
        }
    }
    
    func getDessertDetails (idMeal: String) async throws -> DessertDetail{
        
        let detailsURL = detailsBaseURL + idMeal
        
        guard let url = URL(string : detailsURL)else{
            throw KraveKitError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do{
            let decoder = JSONDecoder()
            return try decoder.decode(DetailResponse.self, from: data).meals.first!
        }
        
    }
}
