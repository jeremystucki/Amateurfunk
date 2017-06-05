//
//  QueryingViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QueryingViewControllerInput {
    func displayQuestion(_ question: Question)
}

protocol QueryingViewControllerOutput {
    func viewDidLoad()
}

class QueryingViewController: UITableViewController {

    var presenter: QueryingViewControllerOutput?

    var question: Question?

    init() {
        super.init(style: .grouped)

        title = "Abfragen"
        hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return question != nil ? 2 : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : question!.answers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            return question!.answers[indexPath.row].getTableViewCell()
        }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = question!.query

        return cell
    }

}

extension QueryingViewController: QueryingViewControllerInput {

    func displayQuestion(_ question: Question) {
        self.question = question
        tableView.reloadData()
    }

}
