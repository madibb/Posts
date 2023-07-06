import Foundation

/// type-safe translations
/// Could be generated with SwiftGen.
public enum Translation {
    public static let tabPosts = tr("tab.posts")
    public static let tabInfo = tr("tab.info")
}

extension Translation {
    fileprivate static func tr(_ key: String) -> String {
        NSLocalizedString(key, bundle: .module, comment: "")
    }
}
