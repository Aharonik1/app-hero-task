import UIKit

protocol ResultCoordinator: Coordinator {
}

final class ResultCoordinatorImpl: ResultCoordinator {
    private let toDoList: [ToDo]
    let navigationController: UINavigationController

    init(toDoList: [ToDo], _ navigationController: UINavigationController) {
        self.toDoList = toDoList
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = ResultViewModelImpl(toDoList: toDoList)
        let controller = ResultController(viewModel: viewModel)
        
        navigationController.pushViewController(controller, animated: true)
    }
}
