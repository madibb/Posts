import UIKit

public extension UIView {

    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
