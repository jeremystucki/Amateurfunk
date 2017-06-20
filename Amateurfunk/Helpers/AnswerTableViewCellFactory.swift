//
//  DisplayableAnswerFactory.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

class AnswerTableViewCellFactory {

    static func getTableViewCell(for answer: Answer) -> UITableViewCell {
        switch answer {
        case let textAnswer as TextAnswer:
            return getTableViewCellForTextAnswer(textAnswer)
        default:
            return UITableViewCell()
        }
    }

    private static func getTableViewCellForTextAnswer(_ answer: TextAnswer) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = answer.answer

        return cell
    }

}
