//
//  QuizViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuizViewControllerInput {
    func displayQuestion(_ question: Question)
}

protocol QuizViewControllerOutput {
    func viewDidLoad()

    func didSelectAnswer(_ answer: Answer)
    func didSelectNextQuestion()
}

class QuizViewController: UIViewController {

    var presenter: QuizViewControllerOutput?

    let questionView: UIView
    let buttonView: UIView

    var questionViewController: QuestionViewControllerInput?
    let button: UIButton

    var viewInitialized = false

    init() {
        questionView = UIView()
        buttonView = UIView()

        button = UIButton()

        super.init(nibName: nil, bundle: nil)

        title = "Abfragen"
        hidesBottomBarWhenPushed = true

        button.setTitle("Antwort anzeigen", for: .normal)
        button.setTitleColor(view.tintColor, for: .normal)

        questionView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        buttonView.backgroundColor = .white
        buttonView.addSubview(button)

        buttonView.addConstraints([
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: buttonView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: buttonView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: buttonView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: buttonView, attribute: .trailing, multiplier: 1, constant: 0)
        ])

        view.addSubview(questionView)
        view.addSubview(buttonView)

        view.addConstraints([
            NSLayoutConstraint(item: questionView, attribute: .bottom, relatedBy: .equal, toItem: buttonView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44),

            NSLayoutConstraint(item: questionView, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: questionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: questionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),

            NSLayoutConstraint(item: buttonView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: buttonView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !viewInitialized {
            viewInitialized = true
            presenter?.viewDidLoad()
        }
    }

}

extension QuizViewController: QuizViewControllerInput {

    func displayQuestion(_ question: Question) {
        questionViewController?.view.removeFromSuperview()

        questionViewController = QuestionViewController(question: question, presenter: self, frame: questionView.frame)
        questionView.addSubview(questionViewController!.view)
    }

}

extension QuizViewController: QuestionViewControllerOutput {

    func didSelectAnswer(_ answer: Answer) {

    }

}

//class QuizViewController: UIViewController {
//
//    var presenter: QuizViewControllerOutput?
//
//    var questionView: QuestionViewInput?
//    var didAnswerQuestion: Bool = false
//
//    let questionViewFrame: UIView
//
////    var viewInitialized = false
//
//    init() {
////        super.init(style: .grouped)
//
//        questionViewFrame = UIView()
//        super.init(nibName: nil, bundle: nil)
//
//        title = "Abfragen"
//        hidesBottomBarWhenPushed = true
//
//        view.addSubview(questionViewFrame)
//
////        tableView.estimatedRowHeight = 44
////        tableView.rowHeight = UITableViewAutomaticDimension
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        presenter?.viewDidLoad()
//    }
//
////    override func viewWillAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////
////        if !viewInitialized {
////            viewInitialized = true
////            presenter?.viewDidLoad()
////        }
////    }
//
////    override func numberOfSections(in tableView: UITableView) -> Int {
////        return question != nil ? 3 : 0
////    }
////
////    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return section == 1 ? question!.answers.count : 1
////    }
////
////    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        if indexPath.section == 0 {
////            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
////            cell.selectionStyle = .none
////            cell.textLabel?.numberOfLines = 0
////            cell.textLabel?.text = question!.query
////            cell.textLabel?.textAlignment = .center
////
////            return cell
////        }
////
////        if indexPath.section == 1 {
////            return AnswerTableViewCellFactory.getTableViewCell(for: Array(question!.answers)[indexPath.row])
////        }
////
////        if indexPath.section == 2 {
////            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
////            cell.textLabel?.text = didAnswerQuestion ? "Nächste Frage" : "Antwort anzeigen"
////            cell.textLabel?.textAlignment = .center
////            cell.textLabel?.textColor = view.tintColor
////
////            return cell
////        }
////
////        return UITableViewCell()
////    }
////
////    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////
////        if didAnswerQuestion {
////            if indexPath.section == 2 {
////                presenter?.didSelectNextQuestion()
////            }
////
////            return
////        }
////
////        if indexPath.section == 1 {
////            let answer = Array(question!.answers)[indexPath.row]
////
////            didAnswerQuestion = true
////            presenter?.didSelectAnswer(answer)
////
////            if !answer.correct {
////                UIView.animate(withDuration: 0.1) {
////                    tableView.cellForRow(at: indexPath)?.backgroundColor = .orange
////                }
////            }
////
////            showCorrectAnswer()
////
////            tableView.reloadSections([2], with: .automatic)
////        }
////
////        if indexPath.section == 2 {
////            didAnswerQuestion = true
////            showCorrectAnswer()
////
////            tableView.reloadSections([2], with: .automatic)
////        }
////    }
//
////    private func showCorrectAnswer() {
////        let index = Array(question!.answers).index(where: { $0.correct })!
////
////        UIView.animate(withDuration: 0.1) {
////            self.tableView.cellForRow(at: IndexPath(row: index, section: 1))?.backgroundColor = .green
////        }
////
////        for row in 0..<tableView.numberOfRows(inSection: 1) {
////            tableView.cellForRow(at: IndexPath(row: row, section: 1))?.selectionStyle = .none
////        }
////    }
//
//}
//
//extension QuizViewController: QuizViewControllerInput {
//
//    func displayQuestion(_ question: Question) {
////        let topInset = navigationController!.navigationBar.frame.height
//
//        questionView?.removeFromParentViewController()
//        questionView = QuestionView(question: question, presenter: self)
//
//        questionViewFrame.addSubview(questionView!.uiView)
//
//        didAnswerQuestion = false
//
////        if tableView.numberOfSections == 0 {
////            tableView.reloadData()
////        } else {
////            CATransaction.begin()
////            tableView.beginUpdates()
////
////            CATransaction.setCompletionBlock({
////                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: true)
////            })
////
////            tableView.reloadSections(IndexSet(integersIn: 0..<tableView.numberOfSections), with: .left)
////
////            tableView.endUpdates()
////            CATransaction.commit()
////        }
//    }
//
//}
//
//extension QuizViewController: QuestionViewOutput {
//
//    func didSelectAnswer(_ answer: Answer) {
//        if didAnswerQuestion {
//            return
//        }
//
//        didAnswerQuestion = true
//        presenter?.didSelectAnswer(answer)
//
//        if !answer.correct {
//            questionView?.highlightAnswer(answer: answer, withColor: .orange)
//        }
//
//        questionView?.highlightCorrectAnswer(withColor: .green)
//    }
//
//}
