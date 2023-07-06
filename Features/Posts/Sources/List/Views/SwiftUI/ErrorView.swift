import SwiftUI

struct ErrorView: View {
    private var viewModel: PostListViewModel

    init(viewModel: PostListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: viewModel.errorIcon)
                .font(.system(size: 48))
            Text(viewModel.errorMessage)
            Button {
                viewModel.fetchData(refreshUseCase: .manualButton)
            } label: {
                Image(systemName: "arrow.clockwise.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
            }

        }
        .padding()
    }
}
