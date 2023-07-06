import Foundation
import Combine

import Models
import Utils
import Dependencies

final class PostDetailsViewModel: ObservableObject {

    // MARK: - Private Properties
    @Published var post: PostExtended
    @Published var state: PostExtended.FavoriteState

    // MARK: - Injected Properties
    @Inject var provider: PostsServiceProvider

    @Published var comments = [CommentsInfo]()

    init(post: PostExtended) {
        self.post = post
        self.state = post.retrievePostState()
        post.state = state
    }

    @MainActor
    func fetchComments() async {
        do {
            let comments = try await provider.getCommentsAsync(postId: post.post.id)
            self.comments = comments.map { CommentsInfo(name: $0.name, email: $0.email, body: $0.body) }
        } catch {}
    }

    func toggleState() {
        post.toggleState()
        state = post.state
    }
}

// MARK: - Presentation
extension PostDetailsViewModel {

    var title: String { post.title }

    var body: String { post.body }

    var favoriteButtonImageName: String {
        if post.isFavorite {
            return "star.fill"
        }
        return "star"
    }

}

struct CommentsInfo: Hashable {
    public var name: String
    public var email: String
    public var body: String
}
