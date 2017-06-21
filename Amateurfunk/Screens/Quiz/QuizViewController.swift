//
//  QuizViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuizViewControllerInput {
    func displayQuestion(_ question: Question)
}

protocol QuizViewControllerOutput {
    func viewDidLoad()

    func didSelectAnswer(_ answer: Answer)
    func didSelectNextQuestion()
}

// TODO: Cleanup
class QuizViewController: UITableViewController {

    var presenter: QuizViewControllerOutput?

    var question: Question?
    var didAnswerQuestion: Bool = false

    init() {
        super.init(style: .grouped)

        title = "Abfragen"
        hidesBottomBarWhenPushed = true

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return question != nil ? 3 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? question!.answers.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return AnswerTableViewCellFactory.getTableViewCell(for: Array(question!.answers)[indexPath.row])
        }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textAlignment = .center

        switch indexPath.section {
        case 0:
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = question!.query
        case 2:
            if didAnswerQuestion {
                cell.textLabel?.text = "Nächste Frage"
            } else {
                cell.textLabel?.text = "Antwort anzeigen"
            }

            cell.textLabel?.textColor = view.tintColor
        default:
            break
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if didAnswerQuestion {
            if indexPath.section == 2 {
                presenter?.didSelectNextQuestion()
            }

            return
        }

        if indexPath.section == 0 {
            return
        }

        if indexPath.section == 1 {
            let answer = Array(question!.answers)[indexPath.row]

            presenter?.didSelectAnswer(answer)

            if !answer.correct {
                tableView.cellForRow(at: indexPath)?.backgroundColor = .orange
            }
        }

        didAnswerQuestion = true
        showCorrectAnswer()

        tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.textLabel?.text = "Nächste Frage"
    }

    private func showCorrectAnswer() {
        let index = Array(question!.answers).index(where: { $0.correct })!
        tableView.cellForRow(at: IndexPath(row: index, section: 1))?.backgroundColor = .green

        for row in 0..<tableView.numberOfRows(inSection: 1) {
            tableView.cellForRow(at: IndexPath(row: row, section: 1))?.selectionStyle = .none
        }
    }

}

extension QuizViewController: QuizViewControllerInput {

    func displayQuestion(_ question: Question) {
        let firstLoad = self.question == nil

        self.question = question
        didAnswerQuestion = false

        if firstLoad {
            tableView.reloadData()
        } else {
            tableView.reloadSections([0, 1, 2], with: .left)
        }
    }

}
