//
//  ContentView.swift
//  ToDo
//
//  Created by Josileudo on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var listViewModel: ListViewModel
        
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                ListView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
