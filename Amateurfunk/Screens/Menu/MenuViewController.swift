//
//  TechnikViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 27.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol MenuViewControllerInput {
    func displayMarkedQuestions(numberOfMarkedQuestions: Int)
}

protocol MenuViewControllerOutput {
    func viewWillAppear()

    func didSelectChapterSelection()

    func didSelectQuerying()
    func didSelectFlashCards()
    func didSelectMarkedQuestions()
    func didSelectTestMode()
}

class MenuViewController: UITableViewController {

    var presenter: MenuViewControllerOutput?

    fileprivate var numberOfMarkedQuestions: Int?

    init(title: String) {
        super.init(style: .grouped)

        self.title = title
        tabBarItem = UITabBarItem(title: title, image: nil, tag: 0)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Kapitel wählen",
            style: .plain,
            target: self,
            action: #selector(MenuViewController.didSelectChapterSelection(_:))
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewWillAppear()
    }

    func didSelectChapterSelection(_ gesture: UIGestureRecognizer) {
        presenter?.didSelectChapterSelection()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfMarkedQuestions != nil ? 3 : 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Lernen" : nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator

        if indexPath.section == 0 && indexPath.row == 0 {
            cell.textLabel?.text = "Abfragen"
        }

        if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.text =  "Karteikarten"
        }

        if indexPath.section == 1 && numberOfMarkedQuestions != nil {
            cell.textLabel?.text = "Markierte Fragen"
            cell.detailTextLabel?.text = String(numberOfMarkedQuestions!)
        }

        if (indexPath.section == 1 && numberOfMarkedQuestions == nil) || indexPath.section == 2 {
            cell.textLabel?.text = "Prüfen"
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            presenter?.didSelectQuerying()
        }

        if indexPath.section == 0 && indexPath.row == 1 {
            presenter?.didSelectFlashCards()
        }

        if indexPath.section == 1 && numberOfMarkedQuestions != nil {
            presenter?.didSelectMarkedQuestions()
        }

        if (indexPath.section == 1 && numberOfMarkedQuestions == nil) || indexPath.section == 2 {
            presenter?.didSelectTestMode()
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MenuViewController: MenuViewControllerInput {

    func displayMarkedQuestions(numberOfMarkedQuestions: Int) {
        self.numberOfMarkedQuestions = numberOfMarkedQuestions
        tableView.reloadData()
    }

}
