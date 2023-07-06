import Foundation

/// Error types used in the app user interface
public enum PostsError: Error {
    
    case offline
    case noData
    case unexpected

    var message: String {
        switch self {
        case .offline: return Translation.errorOfflineText
        case .noData: return Translation.errorNoDataText
        case .unexpected: return Translation.errorLoadingText
        }
    }
}
