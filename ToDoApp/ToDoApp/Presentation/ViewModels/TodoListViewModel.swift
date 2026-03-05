//
//  TodoListViewModel.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import Foundation
internal import Combine

@MainActor
final class TodoListViewModel: ObservableObject {
    
    // MARK: — Output
    @Published var todos : [TodoItem] = []
    @Published var newTodoTitle : String = ""
    
    // MARK: - Dependencies
    private let fetchTodosUseCase: FetchTodosUseCase
    private let addTodoUseCase: AddTodosUseCase
    private let repository: TodoRepositoryProtocol
    
    init(
        fetchTodosUseCase: FetchTodosUseCase,
        addTodoUseCase: AddTodosUseCase,
        repository: TodoRepositoryProtocol
    ) {
        self.fetchTodosUseCase = fetchTodosUseCase
        self.addTodoUseCase = addTodoUseCase
        self.repository = repository
    }
    
    func onAppear(){
        loadTodos()
    }
    
    func onAddTapped(){
        addTodoUseCase.execute(title: newTodoTitle)
        loadTodos()
    }
    
    func onToggle(id : UUID) {
        repository.toggleComplete(id: id)
        loadTodos()
    }
    
    func onDelete(id: UUID) {
        repository.delete(id: id)
        loadTodos()
    }
    
    func loadTodos(){
        todos = fetchTodosUseCase.execute()
    }

    
    
    
    
}
