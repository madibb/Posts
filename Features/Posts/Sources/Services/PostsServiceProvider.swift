import Foundation
import Combine

import Dependencies
import NetworkModule
import Models

protocol PostsServiceProvider {
    func getPostsAsync(userId: Int) async throws -> [Post]
    func getPosts(userId: Int) -> AnyPublisher<[Post], PostsError>

    func getCommentsAsync(postId: Int) async throws -> [Comment]
    func getComments(postId: Int) -> AnyPublisher<[Comment], PostsError>
}

final class OurPostsServiceProvider: PostsServiceProvider {
    
    // MARK: Injected dependencies
    @Inject var networkClient: NetworkClient

    init() {}

    // MARK: Posts network requests

    func getPostsAsync(userId: Int) async throws -> [Post] {
        do {
            let params: [String : Any] = ["userId": userId]
            let response: [Post] = try await networkClient.get(endpoint: .posts, params: params)
            return response
        } catch NetworkError.offline {
            throw PostsError.offline
        } catch NetworkError.noData, NetworkError.unexpected, NetworkError.decodingError {
            throw PostsError.unexpected
        }
    }

    func getPosts(userId: Int) -> AnyPublisher<[Post], PostsError> {
        Future { promise in
            Task {
                do {
                    let params: [String : Any] = ["userId": userId]
                    let response: [Post] = try await self.networkClient.get(endpoint: .posts, params: params)
                    let posts = response
                    promise(.success(posts))
                } catch NetworkError.offline {
                    promise(.failure(PostsError.offline))
                } catch NetworkError.noData, NetworkError.unexpected, NetworkError.decodingError {
                    promise(.failure(PostsError.unexpected))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    func getCommentsAsync(postId: Int) async throws -> [Comment] {
        do {
            let params: [String : Any] = ["postId": postId]
            let response: [Comment] = try await networkClient.get(endpoint: .comments, params: params)
            return response
        } catch NetworkError.offline {
            throw PostsError.offline
        } catch NetworkError.noData, NetworkError.unexpected, NetworkError.decodingError {
            throw PostsError.unexpected
        }
    }

    func getComments(postId: Int) -> AnyPublisher<[Comment], PostsError> {
        Future { promise in
            Task {
                do {
                    let params: [String : Any] = ["postId": postId]
                    let response: [Comment] = try await self.networkClient.get(endpoint: .comments, params: params)
                    let posts = response
                    promise(.success(posts))
                } catch NetworkError.offline {
                    promise(.failure(PostsError.offline))
                } catch NetworkError.noData, NetworkError.unexpected, NetworkError.decodingError {
                    promise(.failure(PostsError.unexpected))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
