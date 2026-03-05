//
//  AddTodosUseCase.swift
//  ToDoApp
//
//  Created by Koray Urun on 5.03.2026.
//

import Foundation
final class AddTodosUseCase {
    
    private let repository: TodoRepositoryProtocol
    
    init(repository: TodoRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(title : String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        repository.add(title: title)
    }
    
}
