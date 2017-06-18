//
//  ChapterSelectionViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol ChapterSelectionViewControllerInput {
    func displayChapters(_ chapters: [Chapter])
    func displaySelectedChapters(_ chapters: [Chapter])

    func displayError(withMessage message: String)
}

protocol ChapterSelectionViewControllerOutput {
    func viewDidLoad()

    func didClickCancel()
    func didClickDone(withSelectedChapters selectedChapters: [Chapter])
}

class ChapterSelectionViewController: UITableViewController {

    var presenter: ChapterSelectionViewControllerOutput?

    fileprivate var chapters: [Chapter]?
    fileprivate var selectedChapters = [Chapter]()

    init() {
        super.init(style: .grouped)

        title = "Kapitel wählen"

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Abbrechen",
            style: .plain,
            target: self,
            action: #selector(ChapterSelectionViewController.didClickCancel(_:))
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Fertig",
            style: .done,
            target: self,
            action: #selector(ChapterSelectionViewController.didClickDone(_:))
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

    func didClickCancel(_ gesture: UIGestureRecognizer) {
        presenter?.didClickCancel()
    }

    func didClickDone(_ gesture: UIGestureRecognizer) {
        presenter?.didClickDone(withSelectedChapters: selectedChapters)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return chapters?.count ?? 0
        }

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.textColor = view.tintColor
            cell.textLabel?.text = "Alle auswählen"
            return cell
        }

        let chapter = chapters![indexPath.row]

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = chapter.title

        if selectedChapters.contains(chapter) {
            cell.accessoryType = .checkmark
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath.section == 1 {
            if chapters != nil {
                selectedChapters = chapters!
                tableView.reloadData()
            }

            return
        }

        let chapter = chapters![indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)

        if let index = selectedChapters.index(of: chapter) {
            selectedChapters.remove(at: index)
            cell!.accessoryType = .none
        } else {
            selectedChapters.append(chapter)
            cell!.accessoryType = .checkmark
        }
    }

}

extension ChapterSelectionViewController: ChapterSelectionViewControllerInput {

    func displayChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
        tableView.reloadData()
    }

    func displaySelectedChapters(_ selectedChapters: [Chapter]) {
        self.selectedChapters = selectedChapters
        tableView.reloadData()
    }

    func displayError(withMessage message: String) {
        let alertView = UIAlertController(title: "Fehler", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        present(alertView, animated: true, completion: nil)
    }

}
