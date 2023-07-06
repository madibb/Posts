import Foundation
import SwiftUI
import Combine

import Models
import Utils

final class PostCellViewModel: ObservableObject {

    private let post: PostExtended
    @Published var state: PostExtended.FavoriteState
    @Published var needsUpdate: Bool = false

    init(post: PostExtended) {
        self.post = post
        self.state = post.retrievePostState()
        post.state = state
    }
}

// MARK: - Presentation
extension PostCellViewModel {

    var userId: String { post.userId }

    var title: String { post.title }

    var body: String { post.body }

    var isFavorite: Bool { post.isFavorite }

    var favoriteButtonImageName: String {
        switch post.state {
        case .favorite:
            return "star.fill"
        case .notFavorite:
            return "star"
        }
    }

    func toggleState() {
        post.toggleState()
        state = post.state
    }

    func updateState() {
        needsUpdate = state != post.retrievePostState()
    }
}
