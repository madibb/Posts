import UIKit
import SwiftUI

import Models
import Components
import Dependencies

protocol PostCoordinatorDelegate: AnyObject {
    func routeToDetails(post: PostExtended) -> UIViewController
}

public class PostCoordinator: Coordinating {

    // MARK: - Public property
    public var userId: Int?

    // MARK: - Init
    public init() {}

    // MARK: - Coordinating conformance
    public func start() -> UIViewController {
        guard let userId else {
            preconditionFailure("userId is needed")
        }

        registerDependencies()

        let viewModel = PostListViewModel(userId: userId)
        return PostListViewController(viewModel: viewModel).apply {
            $0.coordinatorDelegate = self
        }
    }

    //MARK: Register service provider dependency
    private func registerDependencies() {
        Dependencies.shared.registerDependency(PostsServiceProvider.self) { _ in
            return OurPostsServiceProvider()
        }
    }
}

extension PostCoordinator: PostCoordinatorDelegate {

    func routeToDetails(post: PostExtended) -> UIViewController {
        let swiftUIView = PostDetailsView(viewModel: .init(post: post))
        return UIHostingController(rootView: swiftUIView)
    }
}
