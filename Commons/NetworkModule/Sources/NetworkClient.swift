import Foundation

/// Enum for HTTP methods
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

/// Protocol for the network client
/// Responsibilities:
/// - sending and receiving (GET / POST / PUT / PATCH) network requests
/// - decoding the JSON object from the data
/// - returns decodable objects to be used further by the users of this client
public protocol NetworkClient {
    func get<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T
    func post<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T
    func put<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T
    func patch<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T
}

/// Implementation of the network client
public final class OurNetworkClient: NetworkClient {

    // MARK: - Private properties
    private let networkService: NetworkService
    private let jsonDecoder: JSONDecoder

    // MARK: - Init
    /// Creates a network client
    /// - Parameters:
    ///   - networkService: The network service which handles REST api network requests
    ///   - jsonDecoder: The JSON decoder. It can be configured for `dateDecodingStrategy`, etc.
    public init(networkService: NetworkService, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.networkService = networkService
        self.jsonDecoder = jsonDecoder
    }

    /// Builds the full URL based on the environment and given endpoint
    /// - Parameter endpoint: The endpoint which will be appended to the base url
    /// - Returns: The full URL
    private func fullUrl(_ endpoint: APIEndpoint) -> URL {
        endpoint.url
    }

    /// Send a request asynchronously
    /// - Parameters:
    ///   - endpoint: The endpoint which is centrally defined in the `APIEndpoint` enum
    ///   - method: One of GET / POST / PUT / PATCH
    ///   - body: An optional request http body
    /// - Returns: Decodable objects to be used further by the users of this client
    private func sendRequest<T: Decodable>(_ endpoint: APIEndpoint, method: HTTPMethod, params: [String: Any]) async throws -> T {
        let url = fullUrl(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.applyParams(params: params)

        let data = try await networkService.sendRequest(request)
        return try decode(T.self, data: data)
    }

    /// Decodes data according to a decodable type and returns the resulting decodable object
    private func decode<T: Decodable>(_ type: T.Type, data: Data?) throws -> T {
        guard let data else {
            throw NetworkError.noData
        }
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            print("Decoding error", error) //TODO: Better logging
            throw NetworkError.decodingError(description: error.localizedDescription)
        }
    }

    public func get<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T {
        return try await sendRequest(endpoint, method: .get, params: params)
    }

    public func post<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T {
        return try await sendRequest(endpoint, method: .post, params: params)
    }

    public func put<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T {
        return try await sendRequest(endpoint, method: .put, params: params)
    }

    public func patch<T: Decodable>(endpoint: APIEndpoint, params: [String: Any]) async throws -> T {
        return try await sendRequest(endpoint, method: .patch, params: params)
    }
}

extension URLRequest {
    static func queryItems(from params: [String: Any]) -> [URLQueryItem] {
        params.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
    }

    mutating func applyParams(params: [String: Any]) {
        // Set parameters based on the HTTP method
        if httpMethod == "GET" {
            guard let url else {
                preconditionFailure("Use applyParams only after setting the url")
            }
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = Self.queryItems(from: params)

            self.url = components?.url
        } else {
            httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
    }
}
