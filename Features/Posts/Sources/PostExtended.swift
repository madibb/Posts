import Foundation
import CoreLocation

import Utils
import Models

class PostExtended {
    enum FavoriteState {
        case favorite
        case notFavorite
    }

    let post: Post
    var state: FavoriteState = .notFavorite

    init(post: Post) {
        self.post = post
        self.state = retrievePostState()
    }
}

extension PostExtended {
    var userId: String { "\(post.userId)" }
    var id: String { "\(post.id)" }
    var title: String { post.title }
    var body: String { post.body }
    var isFavorite: Bool { state == .favorite }

    func toggleState() {
        switch state {
        case .favorite:
            state = .notFavorite
        case .notFavorite:
            state = .favorite
        }
        savePostState()
    }
}

extension PostExtended {
    func savePostState() {
        let key = "\(post.userId)-\(post.id)"
        UserDefaults.standard.set(isFavorite, forKey: key)
    }

    func retrievePostState() -> FavoriteState {
        let key = "\(post.userId)-\(post.id)"
        let isFavorite = UserDefaults.standard.bool(forKey: key)
        if isFavorite {
            return .favorite
        }
        return .notFavorite
    }
}
