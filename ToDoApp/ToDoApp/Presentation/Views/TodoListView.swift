import SwiftUI

struct TodoListView: View {
    
    @StateObject private var viewModel: TodoListViewModel
    
    init(viewModel: TodoListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Input alanı
                HStack {
                    TextField("Yeni todo...", text: $viewModel.newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Ekle") {
                        viewModel.onAddTapped()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.newTodoTitle.isEmpty)
                }
                .padding()
                
                // Liste
                List {
                    ForEach(viewModel.todos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(todo.isCompleted ? .green : .gray)
                                .onTapGesture { viewModel.onToggle(id: todo.id) }
                            
                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                                .foregroundStyle(todo.isCompleted ? .secondary : .primary)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { viewModel.onDelete(id: viewModel.todos[$0].id) }
                    }
                }
            }
            .navigationTitle("Todos")
            .onAppear { viewModel.onAppear() }
        }
    }
}
