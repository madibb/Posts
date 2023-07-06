import SwiftUI

public struct PillView: View {
    var text: String
    var backgroundColor: Color
    var foregroundColor: Color

    // MARK: - Init
    /// A component for a pill with text of a color and a background color
    /// - Parameters:
    ///   - text: The text
    ///   - backgroundColor: The background color
    ///   - foregroundColor: The text color
    public init(text: String, backgroundColor: Color, foregroundColor: Color) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    // MARK: - Content
    public var body: some View {
        Text(text)
            .font(.body)
            .fontWeight(.bold)
            .padding([.leading, .trailing], 24)
            .padding([.top, .bottom], 10)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(20)
    }
}
