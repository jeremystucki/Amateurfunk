import UIKit

protocol ExamViewControllerInput {

}

protocol ExamViewControllerOutput {
    func didSelectStart()
}

class ExamViewController: UITableViewController {

    var presenter: ExamViewControllerOutput?

    convenience init() {
        self.init(style: .plain)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Test starten"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectStart()
    }

}

extension ExamViewController: ExamViewControllerInput {

}
