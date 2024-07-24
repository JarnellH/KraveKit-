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
            Text("Recipe").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.title).padding()
            
        }.frame(width: 385, height: 75 , alignment: .top).padding(.horizontal)
        
        Spacer().frame(height: 20)
            
        //Modal Appearance for Detail View
        VStack{
            
            if let dessert = viewModel.dessert {
                
                AsyncImage(url: URL(string:dessert.strMealThumb), scale: 2.0)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 325 , height: 100)
                    .padding(.top , 90).padding(.bottom , 100)
                    
                //Dessert name and Origin
                VStack{
                    
                    Text(dessert.strMeal)
                        .font(.subheadline).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .colorInvert()
                    
                    Text(dessert.strArea)
                        .font(.callout).colorInvert()
                    
                }.frame(width: 250 , height: 30).padding(10).background(Color.purple)
                    .clipShape(RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                
                //Scrollable Intstructions and Ingredients
                ScrollView{
                    HStack{
                        VStack(alignment: .leading , spacing: 10 ){
                            Text("Instructions: ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text(dessert.strInstructions)
                                .multilineTextAlignment(.center)
                                .font(.body).padding()
                            
                            Text("Ingredients: ").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            
                            //Iterates over the arrays provided by the endpoint to display
                            ForEach(dessert.ingredients.indices , id: \.self) {index in
                                HStack{
                                    Text("\(dessert.ingredients[index])  ").fontWeight(.medium)
                                    Text("\(dessert.measures[index])")
                                }
                            }
                        }.frame(width: 325)
                    }
                }
            }
        }
        .frame(width: 325 , height: 600)
        .background(Color(.systemBackground))
        .cornerRadius(12.0)
        .shadow(radius: 40)
        Spacer()
        
            //Change to task 
            .onAppear{
                viewModel.getDessertDetails(idMeal: idMeal)
            }
    }
}

#Preview {
    DessertDetailView(idMeal:"Place")
}
