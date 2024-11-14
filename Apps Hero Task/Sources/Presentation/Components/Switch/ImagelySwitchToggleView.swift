import UIKit

final class ImagelySwitchToggleView: UIView {
    private let backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()

    private let shadowLayer1: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        return layer
    }()

    private let shadowLayer2: CALayer = {
        let layer = CALayer()
        layer.shadowColor = UIColor.black.withAlphaComponent(0.06).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 1
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = min(bounds.height, bounds.width) / 2
        backgroundLayer.cornerRadius = layer.cornerRadius

        shadowLayer1.frame = bounds
        shadowLayer2.frame = bounds
        backgroundLayer.frame = bounds

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        shadowLayer1.shadowPath = shadowPath
        shadowLayer2.shadowPath = shadowPath
    }

    private func setupView() {
        layer.insertSublayer(backgroundLayer, at: 0)
        layer.insertSublayer(shadowLayer1, below: backgroundLayer)
        layer.insertSublayer(shadowLayer2, below: backgroundLayer)
    }
}
