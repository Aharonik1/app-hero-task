import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        setupView()
        configureView()
        autoLayoutView()
        setupObservers()
    }
    
    func setupView() { }
    
    func configureView() { }
    
    func autoLayoutView() { }
    
    func setupObservers() { }
}

private extension BaseViewController {
    func configureNavigationItem() {
        navigationItem.backButtonTitle = ""
    }
}
