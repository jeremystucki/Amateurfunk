import UIKit

typealias Stats = (questionsAnswered: Int, questionsAnsweredCorrectly: Int)

class QuestionPresenter {

    var viewController: QuestionViewControllerInput?
    var interactor: QuestionInteractorInput?
    var router: QuestionRouterInput?

    var currentStats = Stats(questionsAnswered: 0, questionsAnsweredCorrectly: 0)

    private var currentQuestion: Question?
    private var answeredQuestion: Bool = false
    private var hasNextQuestion: Bool = false

    private func updateStarIcon() {
        if currentQuestion!.marked {
            viewController?.displayFullStar()
        } else {
            viewController?.displayEmptyStar()
        }
    }

    private func getButtonLabel() -> String {
        if !answeredQuestion {
            return "Antwort anzeigen"
        }

        if hasNextQuestion {
            return "Nächste Frage"
        }

        return "Beenden"
    }

    private func updateButtonLabel() {
        viewController?.showButtonLabel(getButtonLabel())
    }

}

extension QuestionPresenter: QuestionViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchNextQuestion()
    }

    func didSelectAnswer(_ answer: Answer) {
        if answeredQuestion {
            return
        }

        answeredQuestion = true

        viewController?.highlightAnswer(answer)

        currentStats.questionsAnswered += 1

        if answer.correct {
            currentStats.questionsAnsweredCorrectly += 1
        } else {
            viewController?.highlightAnswer(currentQuestion!.correctAnswer)
        }

        interactor?.registerChosenAnswer(answer)
        interactor?.fetchHasNextQuestion()
    }

    func didClickStar() {
        if currentQuestion == nil {
            return
        }

        if currentQuestion!.marked {
            interactor?.removeMarkedQuestion(currentQuestion!)
        } else {
            interactor?.addMarkedQuestion(currentQuestion!)
        }

        updateStarIcon()

        interactor?.fetchHasNextQuestion()
    }

    func didClickButton() {
        guard currentQuestion != nil else { return }

        if !answeredQuestion {
            currentStats.questionsAnswered += 1
            viewController?.highlightAnswer(currentQuestion!.correctAnswer)
            answeredQuestion = true
            interactor?.fetchHasNextQuestion()
            return
        }

        if hasNextQuestion {
            interactor?.fetchNextQuestion()
            return
        }

        router?.dismissView()
    }

}

extension QuestionPresenter: QuestionInteractorOutput {

    func fetchedQuestion(_ question: Question) {
        self.currentQuestion = question

        answeredQuestion = false

        viewController?.displayQuestion(question)
        updateStarIcon()
        updateButtonLabel()
    }

    func failedToFetchNextQuestion() {
        // TODO
    }

    func fetchedHasNextQuestion(_ hasNextQuestion: Bool) {
        self.hasNextQuestion = hasNextQuestion
        updateButtonLabel()
    }

    func failedToFetchHasNextQuestion() {
        // TODO
    }

}
