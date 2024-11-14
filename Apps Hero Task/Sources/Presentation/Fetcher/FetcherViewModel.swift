import Foundation
import Combine

protocol FetcherViewModel: AnyObject {
    var state: CurrentValueSubject<FetchState, Never> { get }
    var shouldFetchUserSpecific: CurrentValueSubject<Bool, Never> { get }
    
    func fetchToDoList()
    func showResults()
}

final class FetcherViewModelImpl: FetcherViewModel {
    private let fetchToDoListUseCase: FetchToDoListUseCase
    private var fetchToDoListTask: Task<Void, Never>?
    private var cancellable: AnyCancellable?
    private var toDoList: [ToDo] = []
    private let coordinator: FetcherCoordinator
    
    let state = CurrentValueSubject<FetchState, Never>(.normal)
    let shouldFetchUserSpecific = CurrentValueSubject<Bool, Never>(false)
    
    init(fetchToDoListUseCase: FetchToDoListUseCase, coordinator: FetcherCoordinator) {
        self.fetchToDoListUseCase = fetchToDoListUseCase
        self.coordinator = coordinator
        
        setupObservers()
    }
    
    func fetchToDoList() {
        let userId: Int? = shouldFetchUserSpecific.value ? 5 : nil
        
        fetchToDoListTask?.cancel()
        fetchToDoListTask = Task { @MainActor in
            do {
                toDoList = try await fetchToDoListUseCase.execute(by: userId)
                state.send(.completed)
            } catch {
                state.send(.normal)
            }
        }
    }
    
    func showResults() {
        coordinator.showResults(toDoList: toDoList)
    }
    
    private func setupObservers() {
        cancellable = state
            .removeDuplicates()
            .filter { $0 == .active }
            .sink { [unowned self] state in
                fetchToDoList()
            }
    }
}
