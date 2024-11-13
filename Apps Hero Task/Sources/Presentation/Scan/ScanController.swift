import UIKit

final class ScanController: UIViewController {
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        setupView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
    }
    
    private func configureView() {
        view.backgroundColor = .red
    }
    
}
