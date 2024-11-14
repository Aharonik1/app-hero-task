import Foundation

struct ToDoDTOMapper: Mapper {
    func map(_ input: ToDoDTO) -> ToDo? {
        guard let id = input.id else { return nil }
        guard let userId = input.userId else { return nil }
        guard let completed = input.completed else { return nil }
        guard let title = input.title else { return nil }

        return ToDo(userId: userId, id: id, title: title, completed: completed)
    }
}
