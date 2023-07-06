import Foundation

/// Error types
public enum NetworkError: Error, Equatable {
    case decodingError(description: String)
    case offline
    case unexpected
    case noData
}
