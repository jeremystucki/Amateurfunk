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
}

class ChapterOverviewViewController: UITableViewController {

    var output: ChapterOverviewViewControllerOutput?

    var chapters: [Chapter]?

    override func viewDidLoad() {
        output?.viewInitialized()

        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        cell.textLabel?.text = chapters?[indexPath.row].name

        return cell
    }

}

extension ChapterOverviewViewController: ChapterOverviewViewControllerInput {

    func displayChapters(_ chapters: [Chapter]) {
        self.chapters = chapters
        tableView.reloadData()
    }

}
