import UIKit

final class IconView: BaseView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var icon: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var iconTintColor: UIColor {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(frame.height, frame.width) / 2
    }

    override func setupView() {
        super.setupView()

        addSubview(imageView)
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
}
