//
//  QuestionView.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 02.07.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuestionViewInput {
    func removeFromParentViewController()

    func highlightAnswer(answer: Answer, withColor color: UIColor)
    func highlightCorrectAnswer(withColor color: UIColor)

    var uiView: UIView { get } // TODO: Whatever
}

protocol QuestionViewOutput {
    func didSelectAnswer(_ answer: Answer)
}

class QuestionView: UITableViewController {

    var query: String
    var answers: [Answer]

    var presenter: QuestionViewOutput

    init(question: Question, presenter: QuestionViewOutput) {
        self.query = question.query
        self.answers = Array(question.answers)

        self.presenter = presenter

        super.init(style: .grouped)

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension

//        tableView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
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
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = query
            cell.textLabel?.textAlignment = .center

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
        presenter.didSelectAnswer(answer)
    }

}

extension QuestionView: QuestionViewInput {

    var uiView: UIView {
        return self.view
    }

    func highlightCorrectAnswer(withColor color: UIColor) {
        highlightAnswer(answer: answers.first(where: { $0.correct })!, withColor: color)
    }

    func highlightAnswer(answer: Answer, withColor color: UIColor) {
        let index = answers.index(of: answer)!.littleEndian
        let indexPath = IndexPath(row: index, section: 1)

        UIView.animate(withDuration: 0.1) {
            self.tableView.cellForRow(at: indexPath)?.backgroundColor = color
        }
    }

}
