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
    func viewDidLoad()
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
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = questions![indexPath.row].query

        return cell
    }

}

extension MarkedQuestionsViewController: MarkedQuestionsViewControllerInput {

    func displayQuestions(_ questions: [Question]) {
        self.questions = questions
        tableView.reloadData()
    }

}
