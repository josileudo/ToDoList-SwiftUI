//
//  ListView.swift
//  ToDo
//
//  Created by Josileudo on 11/3/23.
//

import SwiftUI

struct ListView: View {
    @State var items: [ItemModel] = [
        ItemModel(title: "First topic", isCompleted: false),
        ItemModel(title: "Second topic", isCompleted: true),
        ItemModel(title: "Third topic", isCompleted: false)
    ]
    var body: some View {
        List {
            ForEach(items) { item in
                ListRowView(item: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("ToDo List 📋")
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
        }
    }
}


