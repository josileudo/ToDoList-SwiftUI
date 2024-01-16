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
    @Published var customAlertInfo = CustomAlertInfo()
    @Published var isPresentAlert = false
    
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
        collection.addSnapshotListener{( snapshot, error) in
            var test: [ItemModel] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let testValue = try? Firestore.Decoder().decode(ItemModel.self, from: document.data())
                    if ((testValue) != nil) {
                        test.append(testValue!)
                    }
                }
            }
            self.items = test
        }
    }
     
    func deleteItem(indexSet: IndexSet) async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let collection = Firestore.firestore().collection("users").document(uid).collection(itemsListKey)
            for index in indexSet {
                try await collection.document(items[index].id).delete()
            }
        } catch {
            print("Error for delete item at in Firestore: \(error.localizedDescription)")
       }
    }
       
    func addItem(title: String) async throws {
        let newItem = ItemModel(title: title, isCompleted: false)
        do {
            if let encodedData = try? Firestore.Encoder().encode(newItem) {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let db = Firestore.firestore()
                let items = db.collection("users").document(uid).collection(itemsListKey).document(newItem.id)
                try await items.setData(encodedData)
            }
        } catch {
            print("Error for add new item at in Firestore: \(error.localizedDescription)")
        }
    }
    
    func updateItem(item: ItemModel) {
        do {
            if items.firstIndex(where: { $0.id == item.id }) != nil {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let encodedData = try Firestore.Encoder().encode(item.updateCompletion())
                let snapshot = Firestore.firestore().collection("users").document(uid).collection(itemsListKey).document(item.id)
                snapshot.setData(encodedData)
            }
       } catch {
           print("Error for update item at in Firestore: \(error.localizedDescription)")
       }
    }
    
    func showAlertWith(title: String, description: String) {
           DispatchQueue.main.async {
               [weak self] in
               self?.customAlertInfo.title = title
               self?.customAlertInfo.description = description
               self?.isPresentAlert = true
           }
       }
    
    func quantityToDo(type: ItemsListTypes) -> Int {
        return items.filter({task in {
            type.rawValue == "completed" ? task.isCompleted : !task.isCompleted
        }()}).count
    }
}
