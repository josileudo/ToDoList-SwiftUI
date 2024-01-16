//
//  ListView.swift
//  ToDo
//
//  Created by Josileudo on 11/3/23.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var loginView: Bool = false
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                 List {
                    Section {
                        ForEach(listViewModel.items) { item in
                            if(!item.isCompleted) {
                            ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                        listViewModel.updateItem(item: item)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            Task {
                               try await listViewModel.deleteItem(indexSet: indexSet)
                            }
                            
                        }
                    } header: {
                        HStack {
                            Text("To Do")
                            Spacer()
                            Text("\(listViewModel.quantityToDo(type: ItemsListTypes.Todo))")
                        }
                    }
                    
                    Section {
                        ForEach(listViewModel.items) { item in
                            if(item.isCompleted) {
                            ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewModel.updateItem(item: item)
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            Task {
                               try await listViewModel.deleteItem(indexSet: indexSet)
                            }
                            
                        }
                    } header: {
                        HStack {
                            Text("Completed")
                            Spacer()
                            Text("\(listViewModel.quantityToDo(type: ItemsListTypes.Completed))")
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
            }
            VStack {
                Button {
                    authViewModel.signOut()
                } label: {
                    Text("Sign Out")
                }
                
                Button {
                    loginView = true
                } label: {
                    Text("Delete user")
                }
                .alert("Delete User", isPresented: $loginView) {
                    Button("Cancel", role: .cancel, action: {
                        loginView = false
                   })
                    Button("Delete", role: .destructive, action: {
                        Task {
                            do {
                                try await authViewModel.deleteUser()
                            } catch {
                            }
                        }
                    })
                } message: {
                    Text("You wish delete this user?")
                }
            }
            

        }
        .navigationTitle("ToDo List 📋")
        .navigationBarHidden(listViewModel.items.count == 0)
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddView())
        )
    }
}


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }.environmentObject(ListViewModel())
    }
}


