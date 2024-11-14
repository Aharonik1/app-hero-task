import UIKit

extension NSObject {
    var identifier: String {
        String(describing: type(of: self))
    }
    
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
        guard let cell else { fatalError("Can't cast to type \(T.self)") }
        return cell
    }
}
