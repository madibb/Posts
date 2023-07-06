import Foundation

public protocol Applyable {}

public extension Applyable {
    @discardableResult
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Applyable {}
