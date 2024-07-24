//
//  DessertDetailModel.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import Foundation

class DessertDetailModel: ObservableObject{
    
    @Published var dessert: DessertDetail?
    @Published var kraveError: AlertItem?
    @Published var isLoading = false
    
    
    func getDessertDetails(idMeal : String){
        isLoading = true
        
        Task{
            do{
                let info = try await NetworkManager.shared.getDessertDetails(idMeal: idMeal)
                DispatchQueue.main.async{
                    self.dessert = info
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
                    self.isLoading =  false
                }
            }
        }        
    }
}
