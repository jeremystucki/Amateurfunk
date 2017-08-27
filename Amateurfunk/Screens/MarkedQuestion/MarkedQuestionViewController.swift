// TODO: Refactor duplicated code (QuizViewController)

import UIKit

protocol MarkedQuestionViewControllerInput {
    func displayQuestion(_ viewController: UIViewController)
}

protocol MarkedQuestionViewControllerOutput {
    func viewDidLoad()
}

class MarkedQuestionViewController: UIViewController {

    var presenter: MarkedQuestionViewControllerOutput?

    let questionView: UIView
    let buttonView: UIView

    private var question: Question?

    var viewInitialized = false

    init() {
        questionView = UIView()
        buttonView = UIView()

        super.init(nibName: nil, bundle: nil)

        title = "Frage"

        questionView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false

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

//        if #available(iOS 11.0, *) {
//            navigationItem.largeTitleDisplayMode = .never
//        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !viewInitialized {
            viewInitialized = true
            presenter?.viewDidLoad()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        presenter?.viewDidLoad()
    }

}

extension MarkedQuestionViewController: MarkedQuestionViewControllerInput {

    func displayQuestion(_ viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false

        questionView.addSubview(viewController.view)
        addChildViewController(viewController)

        questionView.addConstraints([
            viewController.view.topAnchor.constraint(equalTo: questionView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: questionView.bottomAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: questionView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: questionView.trailingAnchor)
        ])
    }

}
