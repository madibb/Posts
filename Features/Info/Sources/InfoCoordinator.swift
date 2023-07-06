import UIKit
import Components

public struct InfoCoordinator: Coordinating {
    
    // MARK: - Init
    public init() {}

    // MARK: - Coordinating conformance
    public func start() -> UIViewController {
        InfoViewController()
    }
}
