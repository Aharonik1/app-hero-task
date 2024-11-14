import Foundation

protocol ToDoRepository {
    func fetchTodos(by userId: Int?) async throws -> [ToDo]
}

struct ToDoRepositoryImpl: ToDoRepository {
    private let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func fetchTodos(by userId: Int?) async throws -> [ToDo] {
        guard var url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {
            throw URLError(.badURL)
        }
        if let userId {
            url.append(queryItems: [URLQueryItem(name: "userId", value: "\(userId)")])
        }
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let decoded = try JSONDecoder().decode(Array<ToDoDTO>.self, from: data)
        return decoded.compactMap { ToDoDTOMapper().map($0) }
    }
}
