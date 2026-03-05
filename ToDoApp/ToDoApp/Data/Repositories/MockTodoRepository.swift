//
//  MockTodoRepository.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import Foundation

final class MockTodoRepository: TodoRepositoryProtocol {
    
    // in-memory storage
    private var todos: [TodoItem] = [
        TodoItem(title : "Clean Architecture öğren"),
        TodoItem(title: "MVVM pratiği yap"),
        TodoItem(title: "SwiftUI geliştir", isCompleted: true)
    ]
    
    func fetchAll() -> [TodoItem] {
        todos
    }
    
    func add(title: String) {
        todos.append(TodoItem(title: title))
    }
    
    func toggleComplete(id: UUID) {
        guard let index = todos.firstIndex(where: {$0.id == id}) else {return}
        todos[index].isCompleted.toggle()
    }
    
    func delete(id: UUID) {
        todos.removeAll { $0.id == id }
    }
    
}
