import UIKit

public extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }

        return cell
    }
}

protocol IndentifiableViewCell: AnyObject {
    static var identifier: String { get }
}

extension IndentifiableViewCell where Self: UIView {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: IndentifiableViewCell {}
