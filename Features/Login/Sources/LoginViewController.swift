import UIKit
import SwiftUI
import Combine

import Components

class LoginViewController: UIViewController {

    // MARK: - Properties
    private var cancellables = [AnyCancellable]()
    weak var coordinatorDelegate: LoginCoordinatorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let swiftUIView = LoginView(userId: "") { [self] userId in
            login(userId: userId)
        }

        // Create a UIHostingController and set the SwiftUI view as its root view
        let hostingController = UIHostingController(rootView: swiftUIView)

        let loginView = hostingController.view!

        view.addSubview(loginView)
        view.constrain(subview: loginView)

    }

    func login(userId: Int) {
        guard let coordinatorDelegate else {
            preconditionFailure("coordinatorDelegate has not been set for LoginViewController")
        }

        let viewController = coordinatorDelegate.routeToPosts(userId: userId)

        navigationController?.pushViewController(viewController, animated: true)
    }

}
