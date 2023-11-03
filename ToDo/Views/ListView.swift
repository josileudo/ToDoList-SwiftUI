//
//  ListView.swift
//  ToDo
//
//  Created by Josileudo on 11/3/23.
//

import SwiftUI

struct ListView: View {
    @State var items: [String] = [
        "This my first title!",
        "This is my second title",
        "Third"
    ]
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                ListRowView(title: item)
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


