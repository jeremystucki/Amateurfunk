//
//  ChapterOverviewViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 14.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol ChapterOverviewViewControllerInput {
    func displayChapters(_ chapters: [Chapter])
}

protocol ChapterOverviewViewControllerOutput {
    func viewInitialized()

    func didSelectChapters(_ chapters: [Chapter])
}

class ChapterOverviewViewController: UITableViewController {

    var output: ChapterOverviewViewControllerOutput?

    var chapters: [Chapter]?

    init() {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        output?.viewInitialized()
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return chapters == nil || chapters!.count == 0 ? 0 : 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : chapters!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator

        if indexPath.section == 0 {
            cell.textLabel!.text = "Alle Kapitel" // TODO: i18n
        } else {
            cell.textLabel!.text = chapters?[indexPath.row].name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectChapters(indexPath.section == 0 ? chapters! : [chapters![indexPath.row]])
    }

}

extension ChapterOverviewViewController: ChapterOverviewViewControllerInput {

    func displayChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
        tableView.reloadData()
    }

}
