import Foundation

struct ToDoDTO: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let completed: Bool?
}
