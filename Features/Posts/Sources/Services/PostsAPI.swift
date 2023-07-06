import Foundation
import NetworkModule

struct PostUrl: UrlProviding {
    var urlString: String {
        "https://jsonplaceholder.typicode.com/posts"
    }
}

struct CommentsUrl: UrlProviding {
    var urlString: String {
        "https://jsonplaceholder.typicode.com/comments"
    }
}

extension APIEndpoint {
    static var posts: Self {
        .init(urlProviding: PostUrl())
    }

    static var comments: Self {
        .init(urlProviding: CommentsUrl())
    }
}
