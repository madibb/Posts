import XCTest
import Combine

@testable import Models
@testable import NetworkModule
@testable import Posts

final class PostsServiceProviderTests: XCTestCase {

    var sut: OurPostsServiceProvider!
    var mockNetworkClient: MockNetworkClient!
    private var cancellables: [AnyCancellable]!

    override func setUp() {
        sut = .init()
        mockNetworkClient = .init()
        cancellables = [AnyCancellable]()
    }

    override func tearDown() {
        cancellables = nil
        mockNetworkClient = nil
        sut = nil
    }

    func testGetPostsSuccess() async {

        // Given
        sut.networkClient = mockNetworkClient

        mockNetworkClient.expectedDecodable =
        [
            MockPostFactory.makePost1()
        ]

        // When
        do {
            let posts = try await sut.getPostsAsync(userId: 1)

            // Then
            XCTAssertEqual(posts.count, 1)
        } catch {
            XCTFail("Failed with error: \(error.localizedDescription)")
        }

        XCTAssertTrue(mockNetworkClient.didGetEndpoint)
    }

    func testGetPostsError() async {

        // Given
        sut.networkClient = mockNetworkClient

        mockNetworkClient.expectedError = true

        // When
        do {
            let _ = try await sut.getPostsAsync(userId: 1)
            XCTFail("Should have failed")
        } catch {
            // Then
            XCTAssertTrue(error is PostsError)
            XCTAssertEqual(error as! PostsError, .unexpected)
        }

        XCTAssertTrue(mockNetworkClient.didGetEndpoint)
    }

    func testGetPostsSuccess() {

        // Given
        sut.networkClient = mockNetworkClient

        mockNetworkClient.expectedDecodable =
        [
            MockPostFactory.makePost1()
        ]

        // When
        sut.getPosts(userId: 1)
            .sink(receiveCompletion: { result in
                if case let .failure(error) = result {
                    XCTFail("Failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { postList in
                // Then
                XCTAssertEqual(postList.count, 1)
            })
            .store(in: &cancellables)

        XCTAssertTrue(mockNetworkClient.didGetEndpoint)
    }

    func testGetPostsError() {

        // Given
        sut.networkClient = mockNetworkClient

        mockNetworkClient.expectedError = true

        // When
        sut.getPosts(userId: 1)
            .sink(receiveCompletion: { result in
                // Then
                if case let .failure(error) = result {
                    XCTAssertEqual(error, .unexpected)
                }
            }, receiveValue: { _ in
                XCTFail("Should have failed")
            })
            .store(in: &cancellables)
        XCTAssertTrue(mockNetworkClient.didGetEndpoint)
    }
}
