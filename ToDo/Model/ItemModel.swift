//
//  ItemModel.swift
//  ToDo
//
//  Created by Josileudo on 11/8/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct ItemModel: Identifiable, Codable {
    var id: String
    var title: String
    let isCompleted: Bool
    
    init(id: String = NSUUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}

extension ItemModel: FirestoreSerializable {
    init?(documentData: [String: Any]) {
        do {
            self = try Firestore.Decoder().decode(ItemModel.self, from: documentData)
        } catch {
            print("Erro ao decodificar documento: \(error.localizedDescription)")
            return nil
        }
    }
}

enum ItemsListTypes: String {
    case Todo = "todo"
    case Completed = "completed"
}

protocol FirestoreSerializable {
    init?(documentData: [String: Any])
}
