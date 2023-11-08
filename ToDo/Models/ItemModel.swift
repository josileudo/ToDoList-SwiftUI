//
//  ItemModel.swift
//  ToDo
//
//  Created by Josileudo on 11/8/23.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let isCompleted: Bool
}
