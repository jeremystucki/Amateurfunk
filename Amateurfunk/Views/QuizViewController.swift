import UIKit

protocol QuizViewControllerInput {
    func displayQuestion(_ question: Question)

    func displayEmptyStar()
    func displayFullStar()

    func showButtonLabel(_ text: String)

    func highlightAnswer(_ answer: Answer)
}

protocol QuizViewControllerOutput {
    func viewWillAppear()

    func didClickStar()
    func didClickButton()

    func didSelectAnswer(_ answer: Answer)
}

class QuizViewController: UIViewController {

    var presenter: QuizViewControllerOutput?

    private let questionViewContainer = UIView()
    private let buttonViewContainer   = UIView()

    private var questionViewController: QuestionViewController?
    private let buttonView = UIButton(type: .system)

    // swiftlint:disable:next function_body_length
    init(title: String, question: Question? = nil) {
        super.init(nibName: nil, bundle: nil)

        self.title = title
        hidesBottomBarWhenPushed = true

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: nil,
            style: .done,
            target: self,
            action: #selector(didClickStar)
        )

        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 18)

        questionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonViewContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonView.translatesAutoresizingMaskIntoConstraints = false

        buttonView.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)

        buttonViewContainer.backgroundColor = .white
        buttonViewContainer.addSubview(buttonView)

        buttonViewContainer.addConstraints([
            buttonView.topAnchor.constraint(equalTo: buttonViewContainer.topAnchor),
            buttonView.bottomAnchor.constraint(equalTo: buttonViewContainer.bottomAnchor),
            buttonView.leadingAnchor.constraint(equalTo: buttonViewContainer.leadingAnchor),
            buttonView.trailingAnchor.constraint(equalTo: buttonViewContainer.trailingAnchor)
        ])

        view.addSubview(questionViewContainer)
        view.addSubview(buttonViewContainer)

        if #available(iOS 11.0, *) {
            view.addConstraints([
                questionViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                questionViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                questionViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

                buttonViewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                buttonViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                buttonViewContainer.heightAnchor.constraint(equalToConstant: 44),

                questionViewContainer.bottomAnchor.constraint(equalTo: buttonViewContainer.topAnchor)
            ])
        } else {
            // swiftlint:disable line_length
            view.addConstraints([
                NSLayoutConstraint(item: questionViewContainer, attribute: .bottom, relatedBy: .equal, toItem: buttonViewContainer, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonViewContainer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44),

                NSLayoutConstraint(item: questionViewContainer, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: questionViewContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: questionViewContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),

                NSLayoutConstraint(item: buttonViewContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonViewContainer, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: buttonViewContainer, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            ])
            // swiftlint:enable line_length
        }

        if question != nil {
            displayQuestion(question!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    @objc func didClickStar() {
        presenter?.didClickStar()
    }

    @objc func didPressButton() {
        presenter?.didClickButton()
    }

    func displayQuestion(_ question: Question) {
        questionViewController?.view.removeFromSuperview()

        questionViewController = QuestionViewController(question: question, presenter: self)
        questionViewContainer.addSubview(questionViewController!.view)

        questionViewController!.view.translatesAutoresizingMaskIntoConstraints = false

        questionViewContainer.addConstraints([
            questionViewController!.view.topAnchor.constraint(equalTo: questionViewContainer.topAnchor),
            questionViewController!.view.bottomAnchor.constraint(equalTo: questionViewContainer.bottomAnchor),
            questionViewController!.view.leadingAnchor.constraint(equalTo: questionViewContainer.leadingAnchor),
            questionViewController!.view.trailingAnchor.constraint(equalTo: questionViewContainer.trailingAnchor)
        ])
    }

}

extension QuizViewController: QuizViewControllerInput {

    func displayEmptyStar() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "star") // TODO: Rename image
        navigationItem.rightBarButtonItem?.accessibilityLabel = "star unselected"
    }

    func displayFullStar() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "star_selected")
        navigationItem.rightBarButtonItem?.accessibilityLabel = "star selected"
    }

    func showButtonLabel(_ title: String) {
        buttonView.setTitle(title, for: .normal)
    }

    func highlightAnswer(_ answer: Answer) {
        questionViewController?.highlightAnswer(answer)
    }

}

extension QuizViewController: QuestionViewControllerOutput {

    func didSelectAnswer(_ answer: Answer) {
        presenter?.didSelectAnswer(answer)
    }

}
