//
// Created by Jeremy Stucki on 10.04.17.
// Copyright (c) 2017 Jeremy Stucki. All rights reserved.
//

import UIKit
import CoreData

protocol DisplayableAnswer {
    func getCell() -> UITableViewCell
}

extension TextAnswer: DisplayableAnswer {

    func getCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = answer

        return cell
    }

}

extension ImageAnswer: DisplayableAnswer {

    func getCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = "Image placeholder"

        return cell
    }

}
