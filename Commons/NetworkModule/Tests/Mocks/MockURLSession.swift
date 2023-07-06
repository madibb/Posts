import Foundation
import NetworkModule

// MARK: Mock for the session
final class MockURLSession: URLSessionProtocol {

    var expectedData: Data!
    var didCallData = false

    init() {}

    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        
        didCallData = true

        if request.url?.lastPathComponent == "wrong" {
            throw URLError(.badURL)
        }

        let response = URLResponse(url: request.url!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        return (expectedData, response)
    }
}
