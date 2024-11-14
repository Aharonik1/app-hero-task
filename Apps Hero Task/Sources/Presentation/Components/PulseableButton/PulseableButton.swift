import UIKit

final class PulseableButton: UIControl {
    
    private var timer: Timer?
    private var pulseLayers: [CALayer] = []
    
    private let maxScale: CGFloat = 2.0
    private let maxOpacity: CGFloat = 0.0
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .mainForeground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let backgroundLayer = CALayer()
    
    var icon: UIImage? {
        get { iconImageView.image }
        set { iconImageView.image = newValue?.withRenderingMode(.alwaysTemplate) }
    }
    
    var buttonState: PulseableButtonState = .normal {
        didSet {
            updateState(for: buttonState)
        }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius = max(frame.height, frame.width) / 2
        layer.cornerRadius = radius
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = radius
    }
    
    private func setupView() {
        addSubview(iconImageView)
        layer.insertSublayer(backgroundLayer, at: 0)
    }
    
    private func configureView() {
        backgroundColor = .buttonNormal
        backgroundLayer.backgroundColor = UIColor.buttonNormal.cgColor
    }

    private func autoLayoutView() {
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func updateState(for state: PulseableButtonState) {
        iconImageView.tintColor = state.foregroundColor
        backgroundLayer.backgroundColor = state.backgroundColor.cgColor
        switch state {
        case .normal, .completed:
            stopPulseAnimation()
        case .active:
            startPulseAnimation()
        }
    }
    
    private func startAnimation() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animator), userInfo: nil, repeats: true)
    }
    
    @objc private func animator() {
        let pulseLayer = createPulseLayer()
        layer.insertSublayer(pulseLayer, below: backgroundLayer)
        pulseLayers.append(pulseLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = maxScale
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = maxOpacity
        
        let group = CAAnimationGroup()
        group.animations = [scaleAnimation, opacityAnimation]
        group.duration = 1.5
        group.repeatCount = 1
        group.isRemovedOnCompletion = true
        
        pulseLayer.add(group, forKey: "pulse")
        
        if pulseLayers.count > 4 {
            let tempLayers = pulseLayers.dropLast(4)
            pulseLayers.removeLast(4)
            pulseLayers.forEach {
                $0.removeAllAnimations()
                $0.removeFromSuperlayer()
            }
            pulseLayers = Array(tempLayers)
        }
    }
    
    private func createPulseLayer() -> CALayer {
        let pulseLayer = CALayer()
        pulseLayer.frame = bounds
        pulseLayer.cornerRadius = bounds.width / 2
        pulseLayer.backgroundColor = backgroundColor?.cgColor
        pulseLayer.opacity = 1.0
        return pulseLayer
    }
    
    func startPulseAnimation() {
        startAnimation()
    }
    
    func stopPulseAnimation() {
        timer?.invalidate()
        timer = nil
        
        for pulseLayer in pulseLayers {
            pulseLayer.removeAllAnimations()
            pulseLayer.removeFromSuperlayer()
        }
        pulseLayers.removeAll()
        
        layer.removeAllAnimations()
    }
}
