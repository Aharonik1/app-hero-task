import UIKit

final class FetchActionView: BaseView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let showButton: RoundButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 36, bottom: 16, trailing: 36)
        let button = RoundButton()
        button.configuration = configuration
        button.setTitle("Show Results", for: .normal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.backgroundColor = .buttonActive
        return button
    }()
    
    let switchControl: ImagelySwitchControl = {
        let control = ImagelySwitchControl()
        control.onTintColor = .buttonActive
        control.onImage = UIImage(systemName: "person.slash.fill")
        control.offImage = UIImage(systemName: "person.fill")
        control.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return control
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
    
    override func setupView() {
        super.setupView()
        
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(showButton)
        contentStackView.addArrangedSubview(switchControl)
    }
    
    override func configureView() {
        super.configureView()
        
        backgroundColor = .buttonNormal.withAlphaComponent(0.6)
    }
    
    override func autoLayoutView() {
        super.autoLayoutView()
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            switchControl.widthAnchor.constraint(equalToConstant: 72),
            switchControl.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
}
