//
//  ListViewModel.swift
//  ToDo
//
//  Created by Josileudo on 11/20/23.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 CREATE
 READ
 UPDATE
 DELETE
 */

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsListKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsListKey),
            let savedData = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedData
    }
     
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet);
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem);
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsListKey)
        }
    }
    
    func quantityToDo(type: ItemsListTypes) -> Int {
        return items.filter({task in {
            type.rawValue == "completed" ? task.isCompleted : !task.isCompleted
        }()}).count
    }
}
