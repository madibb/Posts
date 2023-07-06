import Foundation
import Combine

import Models
@testable import Posts

// MARK: Mock for the posts service provider
final class MockPostsServiceProvider: PostsServiceProvider {

    var expectedPostsError: Bool = false
    var expectedPosts: [Post]!

    var didGetPostsCount = 0
    var didGetPostsCalled: Bool { didGetPostsCount > 0 }

    var expectedCommentsError: Bool = false
    var expectedComments: [Comment]!

    var didGetCommentsCount = 0
    var didGetCommentsCalled: Bool { didGetCommentsCount > 0 }

    func getPostsAsync(userId: Int) async throws -> [Models.Post] {
        didGetPostsCount += 1

        if expectedPostsError {
            throw PostsError.unexpected
        }

        return expectedPosts
    }

    func getPosts(userId: Int) -> AnyPublisher<[Post], PostsError> {
        didGetPostsCount += 1

        if expectedPostsError {
            return Fail(error: PostsError.unexpected)
                .eraseToAnyPublisher()
        }

        return Just(expectedPosts)
            .setFailureType(to: PostsError.self)
            .eraseToAnyPublisher()

    }

    func getCommentsAsync(postId: Int) async throws -> [Models.Comment] {
        didGetCommentsCount += 1

        if expectedCommentsError {
            throw PostsError.unexpected
        }

        return expectedComments
    }

    func getComments(postId: Int) -> AnyPublisher<[Models.Comment], PostsError> {
        didGetCommentsCount += 1

        if expectedCommentsError {
            return Fail(error: PostsError.unexpected)
                .eraseToAnyPublisher()
        }

        return Just(expectedComments)
            .setFailureType(to: PostsError.self)
            .eraseToAnyPublisher()
    }
}
