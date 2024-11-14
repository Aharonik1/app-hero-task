import Combine
import Foundation

enum ResultSection {
    case complete
    case inComplete
    
    var title: String {
        switch self {
        case .complete:
            return "Completed"
        case .inComplete:
            return "Not completed"
        }
    }
}

protocol ResultViewModel: AnyObject {
    var toDoList: CurrentValueSubject<[ToDo], Never> { get }
    var sections: [ResultSection] { get }
    var incompleteToDoList: [ToDo] { get }
    var completedToDoList: [ToDo] { get }
    
    func toggleToDoStatus(at index: IndexPath)
}

final class ResultViewModelImpl: ResultViewModel {
    let toDoList: CurrentValueSubject<[ToDo], Never>
    var sections: [ResultSection] {
        [
            incompleteToDoList.isEmpty ? nil : ResultSection.inComplete,
            completedToDoList.isEmpty ? nil : ResultSection.complete,
        ].compactMap { $0 }
    }
    var incompleteToDoList: [ToDo] {
        toDoList.value.filter { !$0.completed }
    }

    var completedToDoList: [ToDo] {
        toDoList.value.filter { $0.completed }
    }
    
    init(toDoList: [ToDo]) {
        self.toDoList = .init(toDoList)
    }
    
    func toggleToDoStatus(at index: IndexPath) {
        let model: ToDo
        switch sections[index.section] {
        case .complete:
            model = completedToDoList[index.row]
        case .inComplete:
            model = incompleteToDoList[index.row]
        }
        guard let index = toDoList.value.firstIndex(where: { $0.id == model.id }) else {
            return
        }
        toDoList.value[index].completed.toggle()
    }
}
