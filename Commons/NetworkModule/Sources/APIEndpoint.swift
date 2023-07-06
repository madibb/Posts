import Foundation

/// Used by external modules / features to provide their domain urls
public protocol UrlProviding {
    var urlString: String { get }
}

/// Used by the network client and extended by each feature, like this:
/**
 extension APIEndpoint {
     static var posts: Self {
         .init(urlProviding: PostUrl())
     }
 }
*/
public struct APIEndpoint {
    // MARK: - Private property
    private let urlProviding: UrlProviding

    // MARK: - Computed variable
    public var url: URL { urlProviding.url }

    // MARK: - Init
    public init(urlProviding: UrlProviding) {
        self.urlProviding = urlProviding
    }
}

private extension UrlProviding {
    var url: URL {
        guard let url = URL(string: urlString) else {
            preconditionFailure("Invalid url: \(urlString)")
        }
        return url
    }
}
