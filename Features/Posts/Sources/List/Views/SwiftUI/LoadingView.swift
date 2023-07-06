import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 32) {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
            Text(Translation.loadingText)
        }
        .padding()
    }
}
