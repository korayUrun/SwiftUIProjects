//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            
            let repository = MockTodoRepository()
            let fetchUseCase = FetchTodosUseCase(repository: repository)
            let addUseCase = AddTodosUseCase(repository: repository)
            
            let viewModel = TodoListViewModel(
                fetchTodosUseCase: fetchUseCase,
                addTodoUseCase: addUseCase,
                repository: repository)
            
            TodoListView(viewModel: viewModel)

        }
        
    }
}
