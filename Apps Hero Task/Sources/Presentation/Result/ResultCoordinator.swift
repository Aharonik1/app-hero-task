import UIKit

protocol ResultCoordinator: Coordinator {
    func close()
}

final class ResultCoordinatorImpl: ResultCoordinator {
    private let toDoList: [ToDo]
    let navigationController: UINavigationController

    init(toDoList: [ToDo], _ navigationController: UINavigationController) {
        self.toDoList = toDoList
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ResultViewModelImpl(toDoList: toDoList, coordinator: self)
        let controller = ResultController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    func close() {
        navigationController.popViewController(animated: true)
    }
}
