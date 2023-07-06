import Foundation

/// Protocol for network service
public protocol NetworkService {
    /// Sends a request
    /// - Parameters:
    ///   - request: A network request which will be ignored in case of using mock data.
    /// - Returns: A data object which will be decoded by the `NetworkClient` at a later step
    func sendRequest(_ request: URLRequest) async throws -> Data?
}

/// Implementation of network service using URLSession
public final class OurNetworkService: NetworkService {
    
    // MARK: - Private properties
    private let session: URLSessionProtocol

    // MARK: - Init
    /// Creates a network service
    /// - Parameter session: A session protocol which has a data load method
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    /// Creates a network service that facilitates the sending of actual requests
    /// - Parameters:
    ///   - request: The network request
    ///   - endpoint: An endpoint, it will be ignored in this implementation
    /// - Returns: A data object which will be decoded by the `NetworkClient` at a later step
    public func sendRequest(_ request: URLRequest) async throws -> Data? {
        do {
            print("Sending request: \(request.debugDescription)")

            // Randomly fail the API call
           // let shouldFail = Bool.random() && Bool.random() // 25% probability to fail
            let shouldFail = false
            guard !shouldFail else {
                throw NetworkError.unexpected
            }

            let (data, _) = try await session.data(for: request)
            return data
        } catch {
            guard let urlError = error as? URLError, urlError.code == .notConnectedToInternet else {
                throw NetworkError.unexpected
            }
            throw NetworkError.offline
        }
    }
}
