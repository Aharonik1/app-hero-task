import UIKit
import Combine

final class FetcherViewController: BaseViewController {
    private let viewModel: FetcherViewModel
    private var cancellable: AnyCancellable?
    
    private let fetchButton: PulseableButton = {
        let button = PulseableButton()
        button.icon = UIImage(systemName: "wifi")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let infoView: InfoView = {
        let view = InfoView()
        view.text = "Tap on the button to fetch todos"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let actionView: FetchActionView = {
        let view = FetchActionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: FetcherViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {
        super.setupView()

        view.addSubview(fetchButton)
        view.addSubview(infoView)
        view.addSubview(actionView)
    }

    override func configureView() {
        super.configureView()

        view.backgroundColor = .mainBackground
        navigationItem.title = "Fetcher"
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fetchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fetchButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            fetchButton.heightAnchor.constraint(equalTo: fetchButton.widthAnchor),
            
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            actionView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 24),
            actionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    override func setupObservers() {
        super.setupObservers()

        fetchButton.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            switch fetchButton.buttonState {
            case .normal, .completed:
                viewModel.state.send(.active)
            case .active:
                viewModel.state.send(.normal)
            }
        }), for: .touchUpInside)
        
        actionView.showButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.showResults()
        }), for: .touchUpInside)
        
        actionView.switchControl.addAction(UIAction(handler: { [weak self] _ in
            guard let self else { return }
            viewModel.shouldFetchUserSpecific.value = actionView.switchControl.isSelected
        }), for: .valueChanged)
        
        cancellable = viewModel.state
            .removeDuplicates()
            .sink { [weak self] state in
                self?.updateState(for: state)
            }
    }
    
    private func updateState(for state: FetchState) {
        infoView.text = state.infoText
        actionView.showButton.alpha = state == .completed ? 1.0 : 0.3
        actionView.showButton.isEnabled = state == .completed
        
        switch state {
        case .normal:
            fetchButton.buttonState = .normal
            infoView.stopAnimating()
        case .active:
            fetchButton.buttonState = .active
            infoView.startAnimating()
        case .completed:
            fetchButton.buttonState = .completed
            infoView.stopAnimating()
        }
    }
}
