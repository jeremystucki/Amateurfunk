import UIKit

protocol MarkedQuestionsViewControllerInput {
    func displayQuestions(_ questions: [Question])
}

protocol MarkedQuestionsViewControllerOutput {
    func viewWillAppear()

    func didSelectQuestion(_ question: Question)
}

class MarkedQuestionsViewController: UITableViewController {

    var presenter: MarkedQuestionsViewControllerOutput?

    private var questions: [Question]?

    convenience init() {
        self.init(style: .plain)

        title = "Markierte Fragen"
        hidesBottomBarWhenPushed = true

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = questions![indexPath.row].query
        cell.textLabel?.numberOfLines = 0

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectQuestion(questions![indexPath.row])
    }

}

extension MarkedQuestionsViewController: MarkedQuestionsViewControllerInput {

    func displayQuestions(_ questions: [Question]) {
        self.questions = questions
        tableView.reloadData()
    }

}
