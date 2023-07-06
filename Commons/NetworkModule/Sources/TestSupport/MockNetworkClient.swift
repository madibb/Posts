import Foundation

// MARK: Mock for the network client
/// To be used by external modules for testing the network client
final class MockNetworkClient: NetworkClient {
    var expectedDecodable: Decodable!
    var expectedError: Bool = false
    var didGetEndpoint = false

    init() {}

    func get<T>(endpoint: NetworkModule.APIEndpoint, params: [String : Any]) async throws -> T where T : Decodable {
        didGetEndpoint = true
        if expectedError {
            throw NetworkError.unexpected
        }
        return expectedDecodable as! T
    }

    func post<T>(endpoint: NetworkModule.APIEndpoint, params: [String : Any]) async throws -> T where T : Decodable { expectedDecodable as! T }

    func put<T>(endpoint: NetworkModule.APIEndpoint, params: [String : Any]) async throws -> T where T : Decodable { expectedDecodable as! T }

    func patch<T>(endpoint: NetworkModule.APIEndpoint, params: [String : Any]) async throws -> T where T : Decodable { expectedDecodable as! T }

}
