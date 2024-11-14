import Foundation

protocol FetchToDoListUseCase {
    func execute(by userId: Int?) async throws -> [ToDo]
}

struct FetchToDoListUseCaseImpl: FetchToDoListUseCase {
    private let repository: ToDoRepository

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func execute(by userId: Int?) async throws -> [ToDo] {
        try await repository.fetchTodos(by: userId)
    }
}
