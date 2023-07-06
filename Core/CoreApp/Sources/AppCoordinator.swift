import UIKit

import Login
import Info
import Components

public final class AppCoordinator: Coordinating {

    // MARK: - Private properties
    private var window: UIWindow
    private let loginCoordinator = LoginCoordinator()
    private let infoCoordinator = InfoCoordinator()

    // MARK: - Init
    public init(window: UIWindow) {
        self.window = window
        window.backgroundColor = .color(.background)
    }

    // MARK: - Coordinating conformance
    public func start() -> UIViewController {
        routeToTab()
    }
}

// MARK: - Route
private extension AppCoordinator {
    func routeToTab() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.applyAppearance()

        tabBarController.viewControllers = [
            UINavigationController(rootViewController: loginCoordinator.start()).apply {
                $0.tabBarItem = UITabBarItem(title: Translation.tabPosts,
                                             image: UIImage(systemName: "list.dash"),
                                             tag: 1)
            },
            UINavigationController(rootViewController: infoCoordinator.start()).apply {
                $0.tabBarItem = UITabBarItem(title: Translation.tabInfo,
                                             image: UIImage(systemName: "lightbulb.circle"),
                                             tag: 2)
            }
        ]

        return tabBarController
    }
}
