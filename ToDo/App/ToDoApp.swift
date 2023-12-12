//
//  ToDoApp.swift
//  ToDo
//
//  Created by Josileudo on 11/1/23.
//

import SwiftUI
import Firebase

@main
struct ToDoApp: App {
    @StateObject private var listViewModel: ListViewModel = ListViewModel()
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
       
        WindowGroup {
            NavigationView() {
                ContentView()
            }.navigationViewStyle(StackNavigationViewStyle()) // for use on ipad
                .environmentObject(listViewModel)
                .environmentObject(authViewModel)
        }
    }
}
