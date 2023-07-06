import UIKit

extension UIView {

    @discardableResult
    public func constrainToCenter(subview: UIView, offset: CGPoint = .zero) -> UIView {
        subview.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            centerYAnchor.constraint(equalTo: subview.centerYAnchor, constant: offset.y),
            centerXAnchor.constraint(equalTo: subview.centerXAnchor, constant: offset.x)
        ])
        
        return self
    }

    @discardableResult
    public func constrainBounds(width: CGFloat? = nil, height: CGFloat? = nil) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            width.map { widthAnchor.constraint(equalToConstant: $0) },
            height.map { heightAnchor.constraint(equalToConstant: $0) }
        ]
            .compactMap { $0 }
        )
        return self
    }

    @discardableResult
    public func constrain(subview: UIView) -> UIView {
        subview.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            subview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        return self
    }

    @discardableResult
    public func constrainToTop(subview: UIView) -> UIView {
        subview.translatesAutoresizingMaskIntoConstraints = false

        addConstraints([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor),
            subview.topAnchor.constraint(equalTo: topAnchor)
        ])

        return self
    }
}
