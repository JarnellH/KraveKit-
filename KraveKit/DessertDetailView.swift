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
            Text("Details of this Dessert").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title).padding()
            


            
        }.frame(width: 385, height: 75 , alignment: .top).padding(.horizontal)
        
        Spacer().frame(height: 20)
            
        
        VStack{
            
            if let dessert = viewModel.dessert {
                
                AsyncImage(url: URL(string:dessert.strMealThumb), scale: 2.0)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 325 , height: 100)
                    .padding(.top , 90)
                    
                
                VStack{
                    
                    Text(dessert.strMeal)
                        .font(.subheadline).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top , 125)
                    
                    Text(dessert.strArea)
                        .font(.callout)
                    
                }.frame(width: 325).padding(10)
                
                ScrollView{
                    
                    VStack(alignment: .leading , spacing: 10 ){
                        
                        Text(dessert.strInstructions)
                            .multilineTextAlignment(.center)
                            .font(.body).padding()

                    }.frame(width: 325)

                }
                
                
            }
            
            
        }
        .frame(width: 325 , height: 600)
        .background(Color(.systemBackground))
        .cornerRadius(12.0)
        .shadow(radius: 40)
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
