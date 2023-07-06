import UIKit

public extension UIColor {
    convenience init(darkMode: UIColor, default defaultColor: UIColor) {
        self.init { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return darkMode
            default:
                return defaultColor
            }
        }
    }

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        formattedString = formattedString.replacingOccurrences(of: "#", with: "")

        guard let hexValue = UInt32(formattedString, radix: 16) else {
            preconditionFailure("Invalid static hex color: \(hexString)")
        }

        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
