import UIKit

final class RoundButton: BaseButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(frame.height, frame.width) / 2
    }
    
    override func setupView() {
        super.setupView()
        
    }
    
    override func configureView() {
        super.configureView()
        
        titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        setTitleColor(.buttonForeground, for: .normal)
        setTitleColor(.buttonForeground, for: .highlighted)
    }
}
