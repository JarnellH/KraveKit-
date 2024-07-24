//
//  RecipeListView.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import Foundation


//Refactor for async/await
class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var kraveError: AlertItem?
    
    @Published var isLoading = false
    

    func getDesserts(){
        isLoading = true
        
        Task{
            do{
                let info = try await NetworkManager.shared.getDesserts()
                DispatchQueue.main.async{
                    self.meals = info
                    self.isLoading = false
                }
                
            }catch{
                DispatchQueue.main.async{
                    if let kraveKitError = error as? KraveKitError{
                        switch kraveKitError{
                        case .invalidURL:
                            self.kraveError = AlertContext.invalidURL
                        case .invalidData:
                            self.kraveError = AlertContext.invalidData
                        case .invalidResponse:
                            self.kraveError = AlertContext.invalidResponse
                        case .unableToComplete:
                            self.kraveError = AlertContext.unableToComplete
                            
                        }
                    }else{
                        self.kraveError = AlertContext.invalidResponse
                    }
                    self.isLoading = false
                }
                
            }
        }
    }
}





