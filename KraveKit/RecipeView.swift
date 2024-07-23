//
//  RecipeView.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/22/24.
//

import SwiftUI

struct RecipeView: View {
    
    @State var searchInput = ""
    @StateObject var viewModel = RecipeListViewModel()
    
    
    var body: some View {
        NavigationView{
            
            List{
                ForEach(viewModel.meals , id: \.idMeal){meal in
                    HStack{
                        
                        AsyncImage(url: URL(string:meal.strMealThumb), scale: 5.0).frame(width: 130 , height: 70).aspectRatio(contentMode: .fill).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        Text(meal.strMeal).bold()
                        
                       
                    }
                    .padding(5)
                }
                
            }
            .navigationTitle("Desserts")
            .onAppear{
                viewModel.getDesserts()
            }
        }
    }
}


#Preview {
    RecipeView()
}


