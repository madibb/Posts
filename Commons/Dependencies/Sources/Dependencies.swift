import Foundation
import Swinject
import Reachability

import NetworkModule
import Utils

/// Responsibility: Handles dependencies.
public final class Dependencies {

    public static let shared = Dependencies()
    
    private let container = Container()

    // MARK: - Init
    init() {
        registerDependencies()
    }
    
    func registerDependencies() {

        //MARK: Network client and service
        registerDependency(NetworkService.self) { _ in
            return OurNetworkService()
        }
        
        registerDependency(NetworkClient.self) { r in
            guard let networkService = r.resolve(NetworkService.self) else {
                preconditionFailure("Dependency NetworkService is missing")
            }

            let jsonDecoder = JSONDecoderFactory.make()

            return OurNetworkClient(networkService: networkService, jsonDecoder: jsonDecoder)
        }

        //MARK: Reachability
        registerDependency(ReachabilityProtocol.self) { _ in
            return try! Reachability()
        }
    }

    //MARK: Helpers for registering and resolving a dependency
    
    public func registerDependency<T>(_ type: T.Type, factory: @escaping(Resolver) -> T) {
        guard container.hasAnyRegistration(of: T.self) == false else { return }
        container.register(T.self, factory: factory)
            .inObjectScope(.container)
    }
    
    fileprivate func resolveDependency<T>() -> T {
        guard let dependency = container.resolve(T.self) else {
            preconditionFailure("Dependency \(T.self) is missing")
        }
        return dependency
    }
}

@propertyWrapper
/// Property wrapper for dependency injection
public struct Inject<T> {
    public var wrappedValue: T
    
    public init() {
        self.wrappedValue = Dependencies.shared.resolveDependency()
    }
}

/// Used to mock the Reachability later
public protocol ReachabilityProtocol {
    var connection: Reachability.Connection { get }
    var whenReachable: Reachability.NetworkReachable? { get set }
    var whenUnreachable: Reachability.NetworkUnreachable? { get set }
    func startNotifier() throws
}

extension Reachability: ReachabilityProtocol {}
