//
//  DisplayableAnswer.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 05.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol DisplayableAnswer {
    func getTableViewCell() -> UITableViewCell
}

extension TextAnswer: DisplayableAnswer {

    func getTableViewCell() -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = answer

        return cell
    }

}
