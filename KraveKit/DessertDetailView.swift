//
//  DessertDetailView.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    //let sweet : DessertDetail
    let idMeal : String
    @StateObject var viewModel = DessertDetailModel()
    
    var body: some View {
        

        
        //Header
        VStack(alignment: .leading , spacing: 5.0){
            Text("Details of this Dessert").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title)
            


            
        }.frame(width: 385, height: 75 , alignment: .top).padding(3)
            
        
        VStack(alignment: .leading , spacing: 10){
            
            if let dessert = viewModel.dessert {
                
                AsyncImage(url: URL(string:dessert.strMealThumb), scale: 3.0).frame(width: 200 , height: 10).scaledToFit()
                
            }
            
            
        }
        Spacer()
        
        
        
        //Image
        
        //Body (instruct and ingredients)Scrollable
        
            .onAppear{
                viewModel.getDessertDetails(idMeal: idMeal)
            }
    }
}

#Preview {
    DessertDetailView(idMeal:"Place")
}
