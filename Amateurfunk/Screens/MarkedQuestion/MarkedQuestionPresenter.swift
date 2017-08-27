import Foundation

class MarkedQuestionPresenter {

    var viewController: QuizViewControllerInput?
    var interactor: MarkedQuestionInteractorInput?
    var router: MarkedQuestionRouterInput?

    private let question: Question

    private var didAnswerQuestion = false

    init(question: Question) {
        self.question = question
    }

    // TODO: Duplicated
    private func updateStarIcon() {
        if question.marked {
            viewController?.displayFullStar()
        } else {
            viewController?.displayEmptyStar()
        }
    }

}

extension MarkedQuestionPresenter: QuizViewControllerOutput {

    func viewWillAppear() {
        updateStarIcon()
        viewController?.showButtonLabel("Antwort anzeigen")
    }

    // TODO: Duplicated
    func didClickStar() {
        if question.marked {
            interactor?.removeMarkedQuestion(question)
        } else {
            interactor?.addMarkedQuestion(question)
        }

        question.marked = !question.marked
        updateStarIcon()
    }

    func didClickButton() {
        viewController?.highlightAnswer(question.correctAnswer)

        // TODO: Hide button
    }

    // TODO: Duplicated
    func didSelectAnswer(_ answer: Answer) {
        if didAnswerQuestion {
            return
        }

        didAnswerQuestion = true
        interactor?.didSelectAnswer(answer)

        viewController?.highlightAnswer(question.correctAnswer)

        if !answer.correct {
            viewController?.highlightAnswer(answer)
        }

        // TODO: Hide button
    }

}

extension MarkedQuestionPresenter: MarkedQuestionInteractorOutput {

}
