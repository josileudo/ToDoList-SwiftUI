//
//  ListViewModel.swift
//  ToDo
//
//  Created by Josileudo on 11/20/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

/*
 CRUD FUNCTIONS
 
 CREATE
 READ
 UPDATE
 DELETE
 */

@MainActor
class ListViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var items: [ItemModel] = []
    
    let itemsListKey: String = "items_list"
    
    init() {
        Task {
           try await getItems()
        }
        
        self.userSession = Auth.auth().currentUser
    }
    
    func getItems() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let collection = Firestore.firestore().collection("users").document(uid).collection(itemsListKey)
        do {
            try await collection.addSnapshotListener{( snapshot, error) in
                var test: [ItemModel] = []
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let testValue = try? Firestore.Decoder().decode(ItemModel.self, from: document.data())
                        if ((testValue) != nil) {
                            test.append(testValue!)
                        }
                        print("*** test inside \(String(describing: testValue))")
                    }
                }
                self.items = test
            }
        } catch {
            print("Error for get items \(error.localizedDescription)")
        }
    }
     
    func deleteItem(indexSet: IndexSet) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let collection = Firestore.firestore().collection("users").document(uid).collection(itemsListKey)
        do {
            for index in indexSet {
                try collection.document(items[index].id).delete()
            }
        } catch {
            
        }
    }
       
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        
        if let encodedData = try? Firestore.Encoder().encode(newItem) {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let db = Firestore.firestore()
            let items = db.collection("users").document(uid).collection(itemsListKey).document(newItem.id)
            items.setData(encodedData)
        }
    }
    
    func updateItem(item: ItemModel) {
        do {
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let encodedData = try Firestore.Encoder().encode(item.updateCompletion())
                let snapshot = Firestore.firestore().collection("users").document(uid).collection(itemsListKey).document(item.id)
                snapshot.setData(encodedData)
            }
       } catch {
           print("Erro ao salvar dados no Firestore: \(error.localizedDescription)")
       }
    }
    
    
    func quantityToDo(type: ItemsListTypes) -> Int {
        return items.filter({task in {
            type.rawValue == "completed" ? task.isCompleted : !task.isCompleted
        }()}).count
    }
}
