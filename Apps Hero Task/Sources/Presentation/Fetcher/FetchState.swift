import Foundation

enum FetchState {
    case normal
    case active
    case completed
    
    var infoText: String {
        switch self {
        case .normal:
            return "Tap on the button to fetch todos"
        case .active:
            return "It’ll take a couple of seconds"
        case .completed:
            return "The fetch successfully completed."
        }
    }
}
