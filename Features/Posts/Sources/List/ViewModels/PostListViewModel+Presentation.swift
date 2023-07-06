import Utils

// MARK: Responsibility: Presentation in the app
extension PostListViewModel {

    var errorMessage: String {
        switch state.value {
        case let .error(error):
            return error.message
        case .outdated:
            return Translation.errorOutdatedText
        default:
            return ""
        }
    }

    var errorIcon: String {
        guard case let .error(error) = state.value else { return "exclamationmark.triangle" }

        switch error {
        case .unexpected: return "exclamationmark.triangle"
        case .noData: return "x.circle"
        case .offline: return "wifi.slash"
        }
    }
}
