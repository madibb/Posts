import UIKit

public extension UITabBar {
    func applyAppearance() {

        let appearance = standardAppearance

        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .color(.background)

        let appearances =
        [appearance.stackedLayoutAppearance,
         appearance.inlineLayoutAppearance,
         appearance.compactInlineLayoutAppearance]

        appearances.map { $0.selected }.forEach {
            $0.iconColor = .color(.primary)
            $0.titleTextAttributes[.foregroundColor] = UIColor.color(.primary)
            $0.titleTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .caption1)
        }

        appearances.map { $0.normal }.forEach {
            $0.iconColor = .color(.onBackground)
            $0.titleTextAttributes[.foregroundColor] = UIColor.color(.onBackground)
            $0.titleTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .caption1)
        }

        standardAppearance = appearance

        scrollEdgeAppearance = standardAppearance
    }
}
