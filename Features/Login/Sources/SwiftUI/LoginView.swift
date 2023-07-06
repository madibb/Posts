import SwiftUI

struct LoginView: View {
    @State var userId: String
    @State var showErrorMessage: Bool = false

    var callback: (Int) -> Void

    var body: some View {
        VStack {
            Spacer()

            Text("Input user ID:")
            TextField("User ID", text: $userId)
                .padding()
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .font(.largeTitle)
                .onChange(of: userId) { _ in
                    showErrorMessage = false
                }

            Button(action: {
                if let userIdInt = Int(userId) {
                    callback(userIdInt)
                } else {
                    showErrorMessage = true
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
            }
            .padding()

            if showErrorMessage {
                Text("Please input a valid user Id integer.")
                    .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
    }
}
