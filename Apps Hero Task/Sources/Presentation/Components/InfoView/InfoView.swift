import UIKit

final class InfoView: UIView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .contentForeground
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hand.tap")
        imageView.tintColor = .contentForeground
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .contentForeground
        return label
    }()

    var text: String? {
        get { textLabel.text }
        set { textLabel.text = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        configureView()
        autoLayoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(contentStackView)

        contentStackView.addArrangedSubview(activityIndicator)
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(textLabel)
    }
    
    private func configureView() {
        backgroundColor = .buttonNormal.withAlphaComponent(0.6)
        layer.cornerRadius = 18
    }

    private func autoLayoutView() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
        ])
    }
}

extension InfoView {
    func startAnimating() {
        activityIndicator.startAnimating()
        iconImageView.isHidden = true
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        iconImageView.isHidden = false
    }
}
