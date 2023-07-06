import UIKit
import SwiftUI
import Combine

import Utils
import Models

final class PostListViewController: UIViewController {

    // MARK: - Private Properties
    private let viewModel: PostListViewModel
    private var cancellables = [AnyCancellable]()

    var tableView: UITableView?

    weak var coordinatorDelegate: PostCoordinatorDelegate?

    // MARK: - Init
    init(viewModel: PostListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        viewModel.fetchData()
        subscribeToData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

        title = Translation.postsTitle.uppercased()
    }

    // MARK: - Data Subscription
    private func subscribeToData() {

        // Show loading / error / data screens:
        viewModel.state.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .error: self.setupErrorView()
            case .loading: self.setupLoadingView()
            default: setupViews()
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - Setup views

    private func setupLoadingView() {
        let swiftUIView = LoadingView()

        // Create a UIHostingController and set the SwiftUI view as its root view
        let hostingController = UIHostingController(rootView: swiftUIView)

        let loadingView = hostingController.view!

        view.removeSubviews()
        view.addSubview(loadingView)
        view.constrain(subview: loadingView)
    }

    private func setupErrorView() {

        let swiftUIView = ErrorView(viewModel: viewModel)

        // Create a UIHostingController and set the SwiftUI view as its root view
        let hostingController = UIHostingController(rootView: swiftUIView)

        let errorView = hostingController.view!

        view.removeSubviews()
        view.addSubview(errorView)
        view.constrain(subview: errorView)
    }

    private func setupViews() {

        view.backgroundColor = .color(.background)

        let segmentedControl = UISegmentedControl(items: ["All", "Favorites"])
            .apply {
                $0.selectedSegmentIndex = 0
                $0.constrainBounds(height: 40)
                $0.selectedSegmentTintColor = .color(.primary)
                $0.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)

            }

        let tableView = UITableView().apply {
            $0.dataSource = self
            $0.delegate = self
            $0.register(PostCell.self)
        }

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)

        tableView.refreshControl = refreshControl
        self.tableView = tableView

        view.removeSubviews()

        let vstack = UIStackView(arrangedSubviews: [segmentedControl, tableView])
            .apply {
                $0.axis = .vertical
                $0.spacing = 10
            }

        view.addSubview(vstack)
        view.constrain(subview: vstack)
    }

    @objc func refreshData() {
        viewModel.fetchData(refreshUseCase: .manualPullToRefresh)
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        viewModel.currentState = index == 0 ? nil: .favorite
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension PostListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.dataSourceCount()
    }

    func numberOfSections(in tableView: UITableView) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(for: indexPath)

        let post = viewModel.dataSourceBy(indexPath: indexPath)
        let postView = post.makeUIView(cancellable: &cancellables) {
            tableView.reloadData()
        }

        // Add the hosting controller's view as a subview to the cell's content view
        cell.contentView.addSubview(postView)
        cell.contentView.constrain(subview: postView)

        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let coordinatorDelegate else {
            preconditionFailure("coordinatorDelegate has not been set for PostListViewController")
        }

        let post = viewModel.dataSourceBy(indexPath: indexPath)
        let viewController = coordinatorDelegate.routeToDetails(post: post)

        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension PostExtended {
    func makeUIView(cancellable: inout [AnyCancellable], onStateChange: @escaping () -> Void) -> UIView {
        let postViewModel = PostCellViewModel(post: self)

         postViewModel.$state
            .dropFirst()
            .removeDuplicates()
            .sink { _ in
                onStateChange()
            }
            .store(in: &cancellable)

        // Create an instance of the SwiftUI view and pass the data
        let contentView = PostCellView(viewModel: postViewModel)

        // Create a UIHostingController and set the SwiftUI view as its root view
        let hostingController = UIHostingController(rootView: contentView)
        return hostingController.view!
    }
}

extension PostListViewController {

    // Render the UITableView again so that it extends correctly after a screen rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            self.tableView?.frame.size = size
        }) { context in
            self.tableView?.reloadData()
        }
    }
}
