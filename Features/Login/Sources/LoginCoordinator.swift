import UIKit

import Components
import Posts

protocol LoginCoordinatorDelegate: AnyObject {
    func routeToPosts(userId: Int) -> UIViewController
}

public class LoginCoordinator: Coordinating {

    // MARK: - Private properties
    private let postCoordinator = PostCoordinator()
    
    // MARK: - Init
    public init() {}

    // MARK: - Coordinating conformance
    public func start() -> UIViewController {
        LoginViewController().apply {
            $0.coordinatorDelegate = self
        }
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {

    func routeToPosts(userId: Int) -> UIViewController {
        postCoordinator.userId = userId
        return postCoordinator.start()
    }
}
