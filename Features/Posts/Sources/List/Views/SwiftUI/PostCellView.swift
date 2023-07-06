import SwiftUI
import Components

struct PostCellView: View {
    @StateObject var viewModel: PostCellViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.title)
                    .font(.title)

                Text(viewModel.body)
                    .font(.caption)

            }
            Spacer()
            VStack {
                Button {
                    viewModel.toggleState()
                } label: {
                    Image(systemName: viewModel.favoriteButtonImageName)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.updateState()
        }
    }
}
