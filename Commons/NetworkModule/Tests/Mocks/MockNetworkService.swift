import Foundation
@testable import NetworkModule

// MARK: Mock for the network service
final class MockNetworkService: NetworkService {

    var expectedData: Data?
    var didSendRequest = false

    init() {}

    func sendRequest(_ request: URLRequest) async throws -> Data? {

        didSendRequest = true

        if request.url?.lastPathComponent == "wrong" {
            throw NetworkError.unexpected
        }

        return expectedData
    }
}
