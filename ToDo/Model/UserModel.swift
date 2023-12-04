//
//  UserModel.swift
//  ToDo
//
//  Created by Josileudo on 11/30/23.
//

import Foundation

struct User: Identifiable, Codable {
    var id: String
    var email: String
    var password: String
    var username: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: username) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, email: "test123@gmail.com", password: "test123", username: "User test")
}
