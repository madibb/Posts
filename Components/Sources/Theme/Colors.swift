import UIKit

public enum Colors {

    case primary
    case secondary
    case background
    case onBackground
    case alert
    case warning

    static let white: UIColor = .init(hexString: "#ffffff")

    fileprivate var uiColor: UIColor {
        switch self {
        case .primary:
            return UIColor(darkMode: .init(hexString: "#ec0016"),
                           default: .init(hexString: "#ec0016"))
        case .secondary:
            return UIColor(darkMode: .init(hexString: "#d7dce1"),
                           default: .init(hexString: "#282d37"))
        case .background:
            return UIColor(darkMode: .init(hexString: "#131821"),
                           default: Colors.white)
        case .onBackground:
            return UIColor(darkMode: Colors.white,
                           default: .init(hexString: "#282d37"))
        case .alert:
            return UIColor(darkMode: .init(hexString: "#f75056"),
                           default: .init(hexString: "#ec0016"))
        case .warning:
            return UIColor(darkMode: .init(hexString: "#f8ab37"),
                           default: .init(hexString: "#F75F00"))
        }
    }

}

public extension UIColor {
    static func color(_ color: Colors) -> UIColor {
        color.uiColor
    }
}
