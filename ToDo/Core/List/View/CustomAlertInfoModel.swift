//
//  CustomAlertInfoModel.swift
//  ToDo
//
//  Created by Josileudo on 12/13/23.
//

import Foundation

struct CustomAlertInfo {
    var title: String
    var description: String
    
    init(title: String = "", description: String = "") {
        self.title = title
        self.description = description
    }
}
