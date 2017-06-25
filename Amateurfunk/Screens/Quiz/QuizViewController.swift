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

class QuizViewController: UITableViewController {

    var presenter: QuizViewControllerOutput?

    var question: Question?
    var didAnswerQuestion: Bool = false

    var viewInitialized = false

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

        if !viewInitialized {
            viewInitialized = true
            presenter?.viewDidLoad()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return question != nil ? 3 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? question!.answers.count : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = question!.query
            cell.textLabel?.textAlignment = .center

            return cell
        }

        if indexPath.section == 1 {
            return AnswerTableViewCellFactory.getTableViewCell(for: Array(question!.answers)[indexPath.row])
        }

        if indexPath.section == 2 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = didAnswerQuestion ? "Nächste Frage" : "Antwort anzeigen"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = view.tintColor

            return cell
        }

        return UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if didAnswerQuestion {
            if indexPath.section == 2 {
                presenter?.didSelectNextQuestion()
            }

            return
        }

        if indexPath.section == 1 {
            let answer = Array(question!.answers)[indexPath.row]

            didAnswerQuestion = true
            presenter?.didSelectAnswer(answer)

            if !answer.correct {
                UIView.animate(withDuration: 0.1) {
                    tableView.cellForRow(at: indexPath)?.backgroundColor = .orange
                }
            }

            showCorrectAnswer()

            tableView.reloadSections([2], with: .automatic)
        }

        if indexPath.section == 2 {
            didAnswerQuestion = true
            showCorrectAnswer()

            tableView.reloadSections([2], with: .automatic)
        }
    }

    private func showCorrectAnswer() {
        let index = Array(question!.answers).index(where: { $0.correct })!

        UIView.animate(withDuration: 0.1) {
            self.tableView.cellForRow(at: IndexPath(row: index, section: 1))?.backgroundColor = .green
        }

        for row in 0..<tableView.numberOfRows(inSection: 1) {
            tableView.cellForRow(at: IndexPath(row: row, section: 1))?.selectionStyle = .none
        }
    }

}

extension QuizViewController: QuizViewControllerInput {

    func displayQuestion(_ question: Question) {
        self.question = question
        didAnswerQuestion = false

        if tableView.numberOfSections == 0 {
            tableView.reloadData()
        } else {
            tableView.reloadSections(IndexSet(integersIn: 0..<tableView.numberOfSections), with: .left)
        }
    }

}
