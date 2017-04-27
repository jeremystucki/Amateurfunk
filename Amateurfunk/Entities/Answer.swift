//
// Created by Jeremy Stucki on 10.04.17.
// Copyright (c) 2017 Jeremy Stucki. All rights reserved.
//

import UIKit
import CoreData

protocol DisplayableAnswer {
    func getCell() -> UITableViewCell
}

extension Answer: DisplayableAnswer {

    func getCell() -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: nil)
    }

}

extension TextAnswer {

    override func getCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = answer

        return cell
    }

}

extension ImageAnswer {

    override func getCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.text = "Image placeholder"

        return cell
    }

}
