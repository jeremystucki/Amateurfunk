//
//  QuestionView.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 02.07.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

// TODO: Cleanup this cancer

import UIKit

protocol QuestionViewControllerInput {
    func highlightAnswer(answer: Answer)
    func highlightCorrectAnswer()

    var viewController: UIViewController! { get }
}

protocol QuestionViewControllerOutput {
    func didSelectAnswer(_ answer: Answer)
    func viewDidLayoutSubviews()
}

extension QuestionViewControllerOutput {
    func didSelectAnswer(_ answer: Answer) { }
    func viewDidLayoutSubviews() { }
}

class QuestionViewController: UITableViewController {

    var viewController: UIViewController! { return self }

    var query: String
    var answers: [Answer]

    var presenter: QuestionViewControllerOutput?

    init(question: Question, presenter: QuestionViewControllerOutput? = nil) {
        self.query = question.query
        self.answers = Array(question.answers)

        self.presenter = presenter

        super.init(style: .grouped)

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : answers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.text = query
            cell.textLabel!.textAlignment = .center

            return cell
        }

        let answer = answers[indexPath.row]
        return AnswerTableViewCellFactory.getTableViewCell(for: answer)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        if indexPath.section == 0 {
            return
        }

        let answer = answers[indexPath.row]
        presenter?.didSelectAnswer(answer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.viewDidLayoutSubviews()
    }

}

extension QuestionViewController: QuestionViewControllerInput {

    func highlightAnswer(answer: Answer, withColor color: UIColor) {
        let index = answers.index(of: answer)!.littleEndian
        let indexPath = IndexPath(row: index, section: 1)

        UIView.animate(withDuration: 0.1) {
            self.tableView.cellForRow(at: indexPath)?.backgroundColor = color
        }
    }

    func highlightCorrectAnswer(withColor color: UIColor) {
        let correctAnswer = answers.first { $0.correct }!
        highlightAnswer(answer: correctAnswer, withColor: color)
    }

    func highlightCorrectAnswer() {
        highlightCorrectAnswer(withColor: .green)
    }

    func highlightAnswer(answer: Answer) {
        highlightAnswer(answer: answer, withColor: .orange)
    }

}
