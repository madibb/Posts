import SwiftUI
import Components

struct PostDetailsView: View {
    @StateObject var viewModel: PostDetailsViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.title)
                        .font(.title)

                    Text(viewModel.body)
                        .font(.caption)
                }
                Button {
                    viewModel.toggleState()
                } label: {
                    Image(systemName: viewModel.favoriteButtonImageName)
                }
            }
            Divider()
            List(viewModel.comments, id: \.self) { comment in
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top) {
                        Text("Email:")
                        Text(comment.email)
                            .font(.headline)
                    }
                    HStack(alignment: .top) {
                        Text("Name:")
                        Text(comment.name)
                            .font(.subheadline)
                    }
                    VStack(alignment: .leading) {
                        Text("Comment:")
                        Text(comment.body)
                            .font(.caption)
                    }
                }.padding()
            }
        }
        .listStyle(.plain)
        .padding()
        .task {
            await viewModel.fetchComments()
        }
    }
}
