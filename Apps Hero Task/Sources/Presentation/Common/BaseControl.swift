import UIKit

class BaseControl: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configureView()
        autoLayoutView()
        setupObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() { }
    
    func configureView() { }
    
    func autoLayoutView() { }
    
    func setupObservers() { }
}
