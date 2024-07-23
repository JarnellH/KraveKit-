//
//  ContentView.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            RecipeView()
        }
    }
}

#Preview {
    ContentView()
}


/**
 ZStack{
     LinearGradient(gradient: Gradient(colors: [.red , . orange]), startPoint: .topLeading , endPoint: .bottomTrailing).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
         
     VStack {
         Text("KraveKit").font(.largeTitle).position(x: 180.0 , y: 0.0)
         
     }
     .padding()
 }
 
 This is a little bit of the login design 
 */
