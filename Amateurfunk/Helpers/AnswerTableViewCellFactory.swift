import UIKit

class AnswerTableViewCellFactory {

    static func getTableViewCell(for answer: Answer) -> UITableViewCell {
        switch answer {
        case let textAnswer as TextAnswer:
            return getTableViewCellForTextAnswer(textAnswer)
        default:
            fatalError("Answer cannot be displayed")
        }
    }

    private static func getTableViewCellForTextAnswer(_ answer: TextAnswer) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = answer.answer
        cell.textLabel!.textAlignment = .center

        return cell
    }

}
