import Gridicons

@objc class CreateButtonCoordinator: NSObject {

    private enum Constants {
        static let padding: CGFloat = -16
        static let heightWidth: CGFloat = 56
    }

    var button: FloatingActionButton = {
        let button = FloatingActionButton(image: Gridicon.iconOfType(.create))
        button.accessibilityLabel = NSLocalizedString("Create", comment: "Accessibility label for create floating action button")
        button.accessibilityIdentifier = "floatingCreateButton"
        return button
    }()

    private weak var viewController: UIViewController?

    let newPost: () -> Void
    let newPage: () -> Void

    @objc init(_ viewController: UIViewController, newPost: @escaping () -> Void, newPage: @escaping () -> Void) {
        self.viewController = viewController
        self.newPost = newPost
        self.newPage = newPage
    }

    /// Should be called any time the `viewController`'s trait collections change
    /// - Parameter previousTraitCollect: The previous trait collection
    @objc func presentingTraitCollectionDidChange(_ previousTraitCollection: UITraitCollection) {
    }

    @objc func add(to view: UIView, trailingAnchor: NSLayoutXAxisAnchor, bottomAnchor: NSLayoutYAxisAnchor) {
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(button)

        let trailingConstraint = button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.padding)
        button.trailingConstraint = trailingConstraint

        NSLayoutConstraint.activate([
            trailingConstraint,
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.padding),
            button.heightAnchor.constraint(equalToConstant: Constants.heightWidth),
            button.widthAnchor.constraint(equalToConstant: Constants.heightWidth)
        ])

        button.addTarget(self, action: #selector(showCreateSheet), for: .touchUpInside)
    }

    @objc private func showCreateSheet() {
//        newPost()
        //TODO: Add Action Sheet here
        newPage()
    }

    @objc func hideCreateButton() {
        button.springAnimation(toShow: false)
    }

    @objc func showCreateButton() {
        button.setNeedsUpdateConstraints() // See `FloatingActionButton` implementation for more info on why this is needed.
        button.springAnimation(toShow: true)
    }

    /// These will be called by the action sheet
    @objc func showNewPost() {
        newPost()
    }

    @objc func showNewPage() {
        newPage()
    }
}
