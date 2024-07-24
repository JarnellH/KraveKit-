//
//  Alert.swift
//  KraveKit
//
//  Created by Jarnell Hayes on 7/24/24.
//


import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    let title : Text
    let message: Text
    let dismissButton : Alert.Button
    
}

struct AlertContext {
    
    //Network Alerts
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("The Data Received was Invalid."),
                                       dismissButton: .default(Text("OK")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                       message: Text("Server's Response was invalid."),
                                       dismissButton: .default(Text("OK")))
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                       message: Text("There was an issue requesting from the URL."),
                                       dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                       message: Text("Unable to process the request. Please check your connection."),
                                       dismissButton: .default(Text("OK")))
}
