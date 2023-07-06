import Foundation
import Reachability

// MARK: Responsibility: Reachability
extension PostListViewModel {

    func observeReachability() {
        do {
            try reachability.startNotifier()
        } catch{
            print("could not start reachability notifier")
        }

        reachability.whenReachable = { [self] _ in
            networkConnectivity.send(true)
            if case .error = state.value {
                state.send(.outdated)
            }
        }

        reachability.whenUnreachable = { [self] _ in
            networkConnectivity.send(false)
        }
    }

}
