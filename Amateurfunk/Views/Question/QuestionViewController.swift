import UIKit

protocol QuestionViewControllerInput {
    func displayQuestion(_ question: Question)
    func highlightAnswer(_ answer: Answer)

    func showButtonLabel(_ text: String)

    func displayEmptyStar()
    func displayFullStar()
}

protocol QuestionViewControllerOutput {
    func viewWillAppear()

    func didSelectAnswer(_ answer: Answer)

    func didClickStar()
    func didClickButton()
}

class QuestionViewController: UIViewController {

    var presenter: QuestionViewControllerOutput?

    private var question: Question?
    private var answers: [Answer]? // TODO: Figure this out

    private let questionTableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let buttonView = UIButton(type: .system)

    init() {
        super.init(nibName: nil, bundle: nil)

        questionTableView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false

        buttonView.backgroundColor = .white
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        buttonView.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)

        view.addSubview(questionTableView)
        view.addSubview(buttonView)

        hidesBottomBarWhenPushed = true
        setupNavigationBar()
        setupConstraints()

        questionTableView.dataSource = self
        questionTableView.delegate = self

        questionTableView.estimatedRowHeight = 44
        questionTableView.rowHeight = UITableViewAutomaticDimension
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupNavigationBar() {
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: nil,
            style: .done,
            target: self,
            action: #selector(didClickStar)
        )
    }

    private func setupConstraints() {
        if #available(iOS 11.0, *) {
            view.addConstraints([
                questionTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                questionTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                questionTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

                buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                buttonView.heightAnchor.constraint(equalToConstant: 44),

                questionTableView.bottomAnchor.constraint(equalTo: buttonView.topAnchor)
            ])
        } else {
            // swiftlint:disable line_length
            view.addConstraints([
                NSLayoutConstraint(item: questionTableView, attribute: .bottom, relatedBy: .equal, toItem: buttonView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44),

                NSLayoutConstraint(item: questionTableView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: questionTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: questionTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),

                NSLayoutConstraint(item: buttonView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            ])
            // swiftlint:enable line_length
        }
    }

    // TODO: Do not use viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    private func highlightAnswer(_ answer: Answer, withColor color: UIColor) {
        let index = answers!.index(of: answer)!.littleEndian
        let indexPath = IndexPath(row: index, section: 1)

        UIView.animate(withDuration: 0.1) {
            self.questionTableView.cellForRow(at: indexPath)?.backgroundColor = color
        }
    }

    @objc private func didClickStar() {
        presenter?.didClickStar()
    }

    @objc func didPressButton() {
        presenter?.didClickButton()
    }

}

extension QuestionViewController: QuestionViewControllerInput {

    func displayQuestion(_ question: Question) {
        self.question = question
        self.answers = Array(question.answers)

        title = "Frage \(question.id)"

        if questionTableView.numberOfSections == 0 {
            questionTableView.reloadData()
        } else {
            CATransaction.begin()
            questionTableView.beginUpdates()

            CATransaction.setCompletionBlock({
                self.questionTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
            })

            questionTableView.reloadSections(IndexSet(integersIn: 0..<questionTableView.numberOfSections), with: .left)

            questionTableView.endUpdates()
            CATransaction.commit()
        }
    }

    func highlightAnswer(_ answer: Answer) {
        highlightAnswer(answer, withColor: (answer.correct ? .green : .orange))
    }

    func showButtonLabel(_ text: String) {
        buttonView.setTitle(text, for: .normal)
    }

    func displayEmptyStar() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "star_unselected")
        navigationItem.rightBarButtonItem?.accessibilityLabel = "star unselected"
    }

    func displayFullStar() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "star_selected")
        navigationItem.rightBarButtonItem?.accessibilityLabel = "star selected"
    }

}

extension QuestionViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return answers?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.text = question!.query
            cell.textLabel!.textAlignment = .center

            return cell
        }

        let answer = answers![indexPath.row]
        return AnswerTableViewCellFactory.getTableViewCell(for: answer)
    }

}

extension QuestionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        if indexPath.section == 0 {
            return
        }

        let answer = answers![indexPath.row]
        presenter?.didSelectAnswer(answer)
    }

}
