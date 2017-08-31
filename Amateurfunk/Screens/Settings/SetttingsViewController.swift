import UIKit

protocol SetttingsViewControllerInput {
    func askForResetConfirmation()
}

protocol SetttingsViewControllerOutput {
    func didSelectReset()

    func didPressConfirm()
    func didPressCancel()
}

class SetttingsViewController: UITableViewController {

    var presenter: SetttingsViewControllerOutput?

    convenience init() {
        self.init(style: .grouped)

        title = "Einstellungen"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Daten zurücksetzen"
        cell.textLabel?.textColor = .red

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didSelectReset()
    }

}

extension SetttingsViewController: SetttingsViewControllerInput {

    func askForResetConfirmation() {
        let alertView = UIAlertController(title: nil, message: "Daten zurücksetzen?", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Zurücksetzen", style: .destructive, handler: { _ in self.presenter?.didPressConfirm() }))
        alertView.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: { _ in self.presenter?.didPressCancel() }))

        present(alertView, animated: true)
    }

}
