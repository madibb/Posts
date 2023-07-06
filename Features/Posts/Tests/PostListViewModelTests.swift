import XCTest
import Combine

import Dependencies
@testable import Models
@testable import Posts

final class PostListViewModelTests: XCTestCase {
    
    var sut: PostListViewModel!
    var mockPostsServiceProvider: MockPostsServiceProvider!

    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        mockPostsServiceProvider = .init()
        mockPostsServiceProvider.expectedPosts = [
            MockPostFactory.makePost1(),
            MockPostFactory.makePost2()
        ]

        Dependencies.shared.registerDependency(PostsServiceProvider.self) { _ in
            return self.mockPostsServiceProvider
        }
    }

    override func tearDown() {
        mockPostsServiceProvider = nil
        sut = nil
    }

    func testLoadDataAutomaticSuccess() {
        
        // Given
        sut = PostListViewModel(userId: 1)
        sut.provider = mockPostsServiceProvider

        // When
        sut.fetchData(refreshUseCase: .automatic)
        
        // Then
        let expectation = XCTestExpectation(description: "State: success")

        sut.state
            .receive(on: DispatchQueue.main)
            .sink { [self] state in
                if case .success = state {
                    XCTAssertEqual(sut.dataSource.count, 2)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)

        wait(for: [expectation], timeout: 2)

        XCTAssertTrue(mockPostsServiceProvider.didGetPostsCalled)
    }

    func testLoadDataAutomaticFailure() {
        // Given
        sut = PostListViewModel(userId: 1)
        sut.provider = mockPostsServiceProvider
        mockPostsServiceProvider.expectedPostsError = true

        // When
        sut.fetchData(refreshUseCase: .automatic)

        // Then
        let expectation = XCTestExpectation(description: "State: error")

        sut.state
            .receive(on: DispatchQueue.main)
            .sink { state in
                if case let .error(postsError) = state {
                    XCTAssertEqual(postsError, .unexpected)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockPostsServiceProvider.didGetPostsCalled)
    }

    func testLoadDataPullToRefreshSuccess() {
        // Given
        sut = PostListViewModel(userId: 1)
        sut.provider = mockPostsServiceProvider

        // When
        sut.fetchData(refreshUseCase: .manualPullToRefresh)

        // Then
        let expectation = XCTestExpectation(description: "State: success")

        sut.state
            .receive(on: DispatchQueue.main)
            .sink { [self] state in
                if case .loading = state {
                    XCTFail("Pull to refresh doesn't use the loading state")
                }
                if case .success = state {
                    XCTAssertEqual(sut.dataSource.count, 2)
                    expectation.fulfill()
                }
            }.store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockPostsServiceProvider.didGetPostsCalled)
    }

    func testLoadDataAutomaticMultipleCalls() {
        // Given
        sut = PostListViewModel(userId: 1)
        sut.provider = mockPostsServiceProvider

        // When
        sut.fetchData(refreshUseCase: .automatic)

        // Then
        let expectation = XCTestExpectation(description: "2 loading requests")

        sut.state
            .receive(on: DispatchQueue.main)
            .sink { [self] state in
                if case .success = state {
                    sut.fetchData(refreshUseCase: .automatic)

                    expectation.fulfill()
                }
            }.store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(mockPostsServiceProvider.didGetPostsCount, 1)
    }

    func testLoadDataNoInternet() {
        // Given
        sut = PostListViewModel(userId: 1)
        sut.provider = mockPostsServiceProvider
        sut.reachability = MockReachability(connection: .unavailable)

        // When
        sut.fetchData(refreshUseCase: .automatic)

        // Then
        if case let .error(postsError) = sut.state.value {
            XCTAssertEqual(postsError, .offline)
        } else {
            XCTFail("Expected the offline error")
        }

        XCTAssertFalse(mockPostsServiceProvider.didGetPostsCalled)
    }
}
