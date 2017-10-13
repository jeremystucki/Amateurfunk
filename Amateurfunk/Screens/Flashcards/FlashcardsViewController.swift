import UIKit

protocol FlashcardsViewControllerInput {
    func displayFlashcardsMetadata(_ metadata: FlashcardsMetadata)
}

protocol FlashcardsViewControllerOutput {
    func viewWillAppear()
    func didSelectStreak(_ streak: Int)
}

class FlashcardsViewController: UITableViewController {

    var presenter: FlashcardsViewControllerOutput?
    var metadata: FlashcardsMetadata?

    convenience init() {
        self.init(style: .plain)

        title = "Karteikarten"
        hidesBottomBarWhenPushed = true

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metadata?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "Fach \(metadata![indexPath.row].streak + 1)" // TODO: Duplicated code
        cell.detailTextLabel?.text = String(metadata![indexPath.row].count)

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectStreak(metadata![indexPath.row].streak)
    }

}

extension FlashcardsViewController: FlashcardsViewControllerInput {

    func displayFlashcardsMetadata(_ metadata: FlashcardsMetadata) {
        self.metadata = metadata.sorted(by: { $0.streak > $1.streak })
        tableView.reloadData()
    }

}
