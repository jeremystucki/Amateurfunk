import UIKit

protocol SetttingsViewControllerInput {

}

protocol SetttingsViewControllerOutput {

}

class SetttingsViewController: UITableViewController {

    var presenter: SetttingsViewControllerOutput?

    convenience init() {
        self.init(style: .grouped)

        title = "Einstellungen"
    }

}

extension SetttingsViewController: SetttingsViewControllerInput {

}
