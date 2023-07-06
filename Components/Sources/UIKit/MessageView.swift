import UIKit
import Utils

public class MessageView: UIView {

    // MARK: - Public properties

    @discardableResult
    public func title(_ title: String) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    public func subtitle(_ subtitle: String) -> Self {
        self.subtitle = subtitle
        return self
    }

    // MARK: - Private properties

    private var title: String {
        didSet {
            updateContent()
        }
    }

    private var subtitle: String? {
        didSet {
            updateContent()
        }
    }

    private let titleLabel = UILabel().apply {
        $0.textColor = .color(.primary)
        $0.font = .preferredFont(forTextStyle: .largeTitle)
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    private let subtitleLabel = UILabel().apply {
        $0.textColor = .color(.secondary)
        $0.font = .preferredFont(forTextStyle: .title1)
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    // MARK: - Init
    /// Create a message view with a title and subtitle
    /// - Parameters:
    ///   - title: The title
    ///   - subtitle: The subtitle
    public init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle

        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & update view
    /// Setups the view initially
    func setupView() {
        self.backgroundColor = .color(.background)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel]).apply {
            $0.axis = .vertical
        }

        addSubview(stackView)
        constrainToCenter(subview: stackView)
        updateContent()
    }

    /// Updates data whenver it changes
    func updateContent() {
        titleLabel.text = title
        if let subtitle {
            subtitleLabel.text = subtitle
        }
    }
}
