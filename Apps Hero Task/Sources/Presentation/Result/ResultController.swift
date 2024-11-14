import UIKit
import Combine

final class ResultController: BaseViewController {
    private let viewModel: ResultViewModel
    private var cancellable: AnyCancellable?

    private let infoView: InfoView = {
        let view = InfoView()
        view.text = "Tap on the todo to change status"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 52
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ResultTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupView() {
        super.setupView()
        
        view.addSubview(infoView)
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()

        view.backgroundColor = .mainBackground
        navigationItem.title = "Todos"
    }
    
    override func autoLayoutView() {
        super.autoLayoutView()
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    override func setupObservers() {
        super.setupObservers()
        
        cancellable = viewModel.toDoList
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
    }
}

extension ResultController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.sections[section] {
        case .complete:
            return viewModel.completedToDoList.count
        case .inComplete:
            return viewModel.incompleteToDoList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultTableViewCell = tableView.dequeue(for: indexPath)
        let model: ToDo
        switch viewModel.sections[indexPath.section] {
        case .complete:
            model = viewModel.completedToDoList[indexPath.row]
        case .inComplete:
            model = viewModel.incompleteToDoList[indexPath.row]
        }
        cell.setup(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleToDoStatus(at: indexPath)
    }
}
