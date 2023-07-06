import Foundation

/// type-safe translations
/// Could be generated with SwiftGen.
public enum Translation {
    static let loadingText = tr("loading.text")
    static let errorOfflineText = tr("error.offline.text")
    static let errorLoadingText = tr("error.loading.text")
    static let errorOutdatedText = tr("error.outdated.text")
    static let errorNoDataText = tr("error.noData.text")
    public static let postsTitle = tr("title.posts")
}

extension Translation {
    fileprivate static func tr(_ key: String) -> String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
}
