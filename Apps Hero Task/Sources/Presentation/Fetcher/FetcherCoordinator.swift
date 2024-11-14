import UIKit

protocol FetcherCoordinator: Coordinator {
    func showResults(toDoList: [ToDo])
}

final class FetcherCoordinatorImpl: FetcherCoordinator {
    let navigationController: UINavigationController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let toDoRepository = ToDoRepositoryImpl(session: URLSession.shared)
        let fetchToDoListUseCase = FetchToDoListUseCaseImpl(repository: toDoRepository)
        let viewModel = FetcherViewModelImpl(fetchToDoListUseCase: fetchToDoListUseCase, coordinator: self)
        let controller = FetcherViewController(viewModel: viewModel)
        navigationController.setViewControllers([controller], animated: true)
    }
    
    func showResults(toDoList: [ToDo]) {
        let coordinator = ResultCoordinatorImpl(toDoList: toDoList, navigationController)
        coordinator.start()
    }
}
