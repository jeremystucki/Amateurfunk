//
//  MarkedQuestionsViewController.swift
//  HB3 Trainer
//
//  Created by Jeremy Stucki on 21.08.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol MarkedQuestionsViewControllerInput {
    func displayQuestions(_ questions: [Question])
}

protocol MarkedQuestionsViewControllerOutput {
    func viewWillAppear()
}

class MarkedQuestionsViewController: UITableViewController {

    var presenter: MarkedQuestionsViewControllerOutput?

    private var questions: [Question]?

    init() {
        super.init(style: .plain)

        title = "Markierte Fragen"
        hidesBottomBarWhenPushed = true

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

}

extension MarkedQuestionsViewController: MarkedQuestionsViewControllerInput {

    func displayQuestions(_ questions: [Question]) {
        self.questions = questions
        tableView.reloadData()
    }

}
