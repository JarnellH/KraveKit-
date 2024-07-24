//
//  Meal.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/24/24.
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
