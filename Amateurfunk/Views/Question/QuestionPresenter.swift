import UIKit

typealias Stats = (questionsAnswered: Int, questionsAnsweredCorrectly: Int)

class QuestionPresenter {

    var viewController: QuestionViewControllerInput?
    var interactor: QuestionInteractorInput?

    var currentStats = Stats(questionsAnswered: 0, questionsAnsweredCorrectly: 0)

    private var currentQuestion: Question?
    private var answeredQuestion: Bool = false
    private var hasNextQuestion: Bool = true

    private func updateStarIcon() {
        if currentQuestion!.marked {
            viewController?.displayFullStar()
        } else {
            viewController?.displayEmptyStar()
        }
    }

    private func updateButtonLabel() {
        if !answeredQuestion {
            viewController?.showButtonLabel("Antwort anzeigen")
            return
        }

        if hasNextQuestion {
            viewController?.showButtonLabel("Nächste Frage")
            return
        }

        viewController?.showButtonLabel("Beenden")
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

        viewController?.highlightAnswer(answer)

        currentStats.questionsAnswered += 1

        if answer.correct {
            currentStats.questionsAnsweredCorrectly += 1
        } else {
            viewController?.highlightAnswer(currentQuestion!.correctAnswer)
        }

        answeredQuestion = true
        updateButtonLabel()

        interactor?.registerChosenAnswer(answer)
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
    }

    func didClickButton() {
        guard currentQuestion != nil else { return }

        if !answeredQuestion {
            currentStats.questionsAnswered += 1
            viewController?.highlightAnswer(currentQuestion!.correctAnswer)
            answeredQuestion = true
            updateButtonLabel()
            return
        }

        if hasNextQuestion {
            interactor?.fetchNextQuestion()
            return
        }
    }

}

extension QuestionPresenter: QuestionInteractorOutput {

    func fetchedQuestion(_ question: Question, hasNextQuestion: Bool) {
        self.currentQuestion = question
        self.hasNextQuestion = hasNextQuestion

        answeredQuestion = false

        viewController?.displayQuestion(question)
        updateStarIcon()
        updateButtonLabel()
    }

    func failedToFetchNextQuestion() {
        // TODO
    }

}
