import Foundation
import Combine

import Dependencies
import Models

final class PostListViewModel {

    enum State {
        case initial
        case loading
        case success
        case error(PostsError)
        case outdated
    }

    // MARK: - Private Properties
    var dataSource: [PostExtended] = [] //TODO: make it private and fix tests
    private var userId: Int

    // MARK: - Internal Properties
    var state: CurrentValueSubject<State, Never> = .init(.initial)
    var networkConnectivity: PassthroughSubject<Bool, Never> = .init()
    var currentState: PostExtended.FavoriteState?

    // MARK: - Private Properties
    private var cancellables = [AnyCancellable]()
    private var isLoaded = false

    // MARK: Injected dependencies
    @Inject var reachability: ReachabilityProtocol
    @Inject var provider: PostsServiceProvider

    // MARK: - Init
    init(userId: Int) {
        self.userId = userId
        observeReachability()
    }

    // MARK: - Filter
    func dataSourceBy(indexPath: IndexPath) -> PostExtended {
        let row = indexPath.row
        return dataSourceByState()[row]
    }

    func dataSourceCount() -> Int {
        dataSourceByState().count
    }

    private func dataSourceByState() -> [PostExtended] {
        guard let currentState else {
            return dataSource
        }
        return dataSource
            .filter { $0.state == currentState }
    }

    // MARK: - Fetch data
    /// Loads post data
    /// - Parameter refreshUseCase: One of `.automatic`, `.manualPullToRefresh`,  `.manualButton`
    func fetchData(refreshUseCase: RefreshUseCase = .automatic) {

        guard reachability.connection != .unavailable else {
            state.send(.error(.offline))
            return
        }

        switch refreshUseCase {
        case .automatic:
            if isLoaded {
                return
            }
            state.send(.loading)
        case .manualPullToRefresh:
            ()
        case .manualButton:
            state.send(.loading)
        }

        provider.getPosts(userId: userId)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] result in
                guard let self else { return }

                if case let .failure(error) = result {
                    self.state.send(.error(error))
                }
            }, receiveValue: { [weak self] postList in
                guard let self else { return }

                if postList.isEmpty {
                    self.state.send(.error(.noData))
                } else {
                    self.state.send(.success)
                }

                self.dataSource = postList.map { PostExtended(post: $0) }

                self.isLoaded = true
            })
            .store(in: &cancellables)
    }
}

/// The data can be refreshed in 3 possible ways:
enum RefreshUseCase {
    case automatic // happens without user interaction, when loading data for the first time
    case manualPullToRefresh // when the user pulls to refresh
    case manualButton // when the user presses the Refresh button in the error screen
}
