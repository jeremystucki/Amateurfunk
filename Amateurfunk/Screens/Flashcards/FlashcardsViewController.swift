import UIKit

protocol FlashcardsViewControllerInput {
    func displayFlashcardsMetadata(_ metadata: FlashcardsMetadata)
}

protocol FlashcardsViewControllerOutput {
    func viewWillAppear()
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
        cell.textLabel?.text = metadata![indexPath.row].compartment
        cell.detailTextLabel?.text = String(metadata![indexPath.row].count)

        return cell
    }

}

extension FlashcardsViewController: FlashcardsViewControllerInput {

    func displayFlashcardsMetadata(_ metadata: FlashcardsMetadata) {
        self.metadata = metadata
        tableView.reloadData()
    }

}
