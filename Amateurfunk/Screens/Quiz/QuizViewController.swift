//
//  QuizViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuizViewControllerInput {
    func displayQuestion(_ view: UIView)

    func showButtonState(_ state: QuizViewController.ButtonState)
}

protocol QuizViewControllerOutput {
    func viewDidLoad()

    func didSelectNextQuestion()
    func didSelectShowAnswer()
}

class QuizViewController: UIViewController {

    var presenter: QuizViewControllerOutput?

    let questionView: UIView
    let buttonView: UIView

    var currentQuestionView: UIView?
    let button: UIButton

    var viewInitialized = false

    enum ButtonState { case showAnswer; case nextQuestion }
    var currentButtonState: ButtonState?

    // swiftlint:disable:next function_body_length
    init() {
        questionView = UIView()
        buttonView = UIView()

        button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)

        super.init(nibName: nil, bundle: nil)

        title = "Abfragen"
        hidesBottomBarWhenPushed = true

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        questionView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)

        buttonView.backgroundColor = .white
        buttonView.addSubview(button)

        buttonView.addConstraints([
            button.topAnchor.constraint(equalTo: buttonView.topAnchor),
            button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: buttonView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: buttonView.trailingAnchor)
        ])

        view.addSubview(questionView)
        view.addSubview(buttonView)

        if #available(iOS 11.0, *) {
            view.addConstraints([
                questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                questionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                questionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

                buttonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                buttonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                buttonView.heightAnchor.constraint(equalToConstant: 44),

                questionView.bottomAnchor.constraint(equalTo: buttonView.topAnchor)
            ])
        } else {
            // swiftlint:disable line_length
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
            // swiftlint:enable line_length
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didPressButton() {
        switch currentButtonState! {
        case .showAnswer:
            presenter?.didSelectShowAnswer()
        case .nextQuestion:
            presenter?.didSelectNextQuestion()
        }
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

    func showButtonState(_ state: QuizViewController.ButtonState) {
        currentButtonState = state

        switch currentButtonState! {
        case .showAnswer:
            button.setTitle("Antwort anzeigen", for: .normal)
        case .nextQuestion:
            button.setTitle("Nächste Frage", for: .normal)
        }
    }

    func displayQuestion(_ view: UIView) {
        currentQuestionView?.removeFromSuperview()

        currentQuestionView = view
        currentQuestionView!.translatesAutoresizingMaskIntoConstraints = false

        questionView.addSubview(currentQuestionView!)

        questionView.addConstraints([
            currentQuestionView!.topAnchor.constraint(equalTo: questionView.topAnchor),
            currentQuestionView!.bottomAnchor.constraint(equalTo: questionView.bottomAnchor),
            currentQuestionView!.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
            currentQuestionView!.trailingAnchor.constraint(equalTo: questionView.trailingAnchor)
        ])
    }

}
