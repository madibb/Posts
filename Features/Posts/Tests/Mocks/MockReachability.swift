import Reachability
import Dependencies

// MARK: Mock for the reachability
struct MockReachability: ReachabilityProtocol {

    var connection: Reachability.Connection

    var whenReachable: Reachability.NetworkReachable? = { _ in }

    var whenUnreachable: Reachability.NetworkUnreachable? = { _ in }

    func startNotifier() throws {}

}
