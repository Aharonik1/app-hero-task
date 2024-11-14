import UIKit

final class ResultTableViewCell: UITableViewCell {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let iconView: IconView = {
        let view = IconView()
        view.backgroundColor = .buttonNormal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = .mainForeground
        return label
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        configureView()
        autoLayoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with model: ToDo) {
        iconView.icon = model.completed ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "multiply")
        iconView.iconTintColor = model.completed ? .buttonActive : .contentForeground
        titleLabel.text = model.title
        statusView.backgroundColor = model.completed ? .buttonActive : .statusError
    }
    
    private func setupView() {
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(iconView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(statusView)
    }
    
    private func configureView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func autoLayoutView() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            
            statusView.widthAnchor.constraint(equalToConstant: 8),
            statusView.heightAnchor.constraint(equalTo: statusView.widthAnchor),
        ])
    }
}
