//
//  TodoRepositoryProtocol.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import Foundation

protocol TodoRepositoryProtocol {
    func fetchAll() -> [TodoItem]
    func add(title: String)
    func toggleComplete(id: UUID)
    func delete(id: UUID)

    
}
