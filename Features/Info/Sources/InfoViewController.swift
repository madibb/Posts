import UIKit
import Components

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let infoView = MessageView(title: "Madalina Maletti")
            .subtitle("July 2023")

        view.addSubview(infoView)

        view.constrain(subview: infoView)
    }

}
