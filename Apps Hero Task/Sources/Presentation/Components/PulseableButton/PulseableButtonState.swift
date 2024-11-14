import UIKit.UIColor

enum PulseableButtonState {
    case normal
    case active
    case completed
    
    var foregroundColor: UIColor {
        switch self {
        case .normal:
            return .mainForeground
        case .active, .completed:
            return .buttonActive
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal:
            return .buttonNormal
        case .active, .completed:
            return .buttonActive.withAlphaComponent(0.15)
        }
    }
}
