//
//  FetchTodosUseCase.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

final class FetchTodosUseCase {
    private let repository: TodoRepositoryProtocol
    
    init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> [TodoItem] {
        repository.fetchAll()
    }
    
    
    
    
}
