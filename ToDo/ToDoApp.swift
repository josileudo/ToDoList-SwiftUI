//
//  ToDoApp.swift
//  ToDo
//
//  Created by Josileudo on 11/1/23.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject private var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView() {
                ListView()
            }
            .navigationViewStyle(StackNavigationViewStyle()) // for use on ipad
            .environmentObject(listViewModel)
        }
    }
}
