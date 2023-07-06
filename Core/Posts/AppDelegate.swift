import UIKit
import CoreApp

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Create the main window
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = .color(.primary)

        self.coordinator = AppCoordinator(window: window)

        window.rootViewController = coordinator.start()
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}
