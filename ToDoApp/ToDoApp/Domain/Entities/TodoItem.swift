//
//  TodoItem.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import Foundation

struct TodoItem : Identifiable, Equatable {
    let id : UUID
    let title : String
    var isCompleted : Bool
    let createdAt : Date
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
