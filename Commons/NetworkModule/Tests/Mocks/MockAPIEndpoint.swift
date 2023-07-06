import Foundation
import NetworkModule

struct MockUrl: UrlProviding {
    let urlString: String = "http://"
}

extension APIEndpoint {
    static var mock: Self {
        .init(urlProviding: MockUrl())
    }
}
