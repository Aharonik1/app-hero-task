import UIKit

final class ImagelySwitchControl: BaseControl {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let onImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .buttonForeground.withAlphaComponent(0.6)
        imageView.alpha = 0.0
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let offImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .buttonForeground.withAlphaComponent(0.6)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let toggleView: ImagelySwitchToggleView = {
        let view = ImagelySwitchToggleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var onTintColor: UIColor?

    var onImage: UIImage? {
        get { onImageView.image }
        set { onImageView.image = newValue }
    }

    var offImage: UIImage? {
        get { offImageView.image }
        set { offImageView.image = newValue }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = min(containerView.frame.height, containerView.frame.width) / 2
    }

    override func setupView() {
        super.setupView()

        addSubview(containerView)
        addSubview(toggleView)

        containerView.addSubview(onImageView)
        containerView.addSubview(offImageView)
    }

    override func configureView() {
        super.configureView()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGesture)
    }

    override func autoLayoutView() {
        super.autoLayoutView()

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),

            onImageView.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16),
            onImageView.heightAnchor.constraint(equalTo: onImageView.widthAnchor),
            onImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            onImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),

            offImageView.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -16),
            offImageView.heightAnchor.constraint(equalTo: offImageView.widthAnchor),
            offImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            offImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

            toggleView.widthAnchor.constraint(equalTo: containerView.heightAnchor, constant: -6),
            toggleView.heightAnchor.constraint(equalTo: toggleView.widthAnchor),
            toggleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            toggleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 3),
        ])
    }

    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let minTranslationX: CGFloat = 3
        let maxTranslationX: CGFloat = frame.width - toggleView.frame.width - 3

        switch gesture.state {
        case .began, .changed:
            let translation = gesture.translation(in: self)
            var newCenterX = toggleView.center.x + translation.x

            newCenterX = max(min(newCenterX, maxTranslationX + toggleView.frame.width / 2), minTranslationX + toggleView.frame.width / 2)
            toggleView.center.x = newCenterX
            gesture.setTranslation(.zero, in: self)

        case .ended, .cancelled, .failed:
            let midPoint = minTranslationX + (maxTranslationX - minTranslationX) / 2
            let targetX: CGFloat
            let isOn: Bool

            if toggleView.center.x > midPoint + toggleView.frame.width / 2 {
                targetX = maxTranslationX
                isOn = true
            } else {
                targetX = minTranslationX
                isOn = false
            }

            UIView.animate(withDuration: 0.25) {
                self.toggleView.frame.origin.x = targetX
                self.updateLayout(isOn: isOn)
                self.isSelected = isOn
                self.sendActions(for: .valueChanged)
            }

        default:
            break
        }
    }

    private func updateLayout(isOn: Bool) {
        containerView.backgroundColor = isOn ? .buttonActive : .white
        onImageView.alpha = isOn ? 1.0 : 0.0
        offImageView.alpha = isOn ? 0.0 : 1.0
    }
}
