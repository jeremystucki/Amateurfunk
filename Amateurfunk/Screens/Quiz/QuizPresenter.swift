class QuizPresenter {

    var viewController: QuizViewControllerInput?
    var interactor: QuizInteractorInput?
    var router: QuizRouterInput?

    var currentQuestion: Question?

    var didAnswerQuestion = false

}

extension QuizPresenter: QuizViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchNextQuestion()
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

        currentQuestion!.marked = !currentQuestion!.marked
        updateStarIcon()
    }

    func didClickButton() {
        if currentQuestion == nil {
            return
        }

        if didAnswerQuestion {
            interactor?.fetchNextQuestion()
        } else {
            didAnswerQuestion = true

            viewController?.highlightAnswer(currentQuestion!.correctAnswer)
            updateButtonLabel()
        }
    }

    private func updateStarIcon() {
        if currentQuestion == nil {
            return
        }

        if currentQuestion!.marked {
            viewController?.displayFullStar()
        } else {
            viewController?.displayEmptyStar()
        }
    }

    private func updateButtonLabel() {
        if didAnswerQuestion {
            viewController?.showButtonLabel("Nächste Frage")
        } else {
            viewController?.showButtonLabel("Antwort anzeigen")
        }
    }

}

extension QuizPresenter: QuestionViewControllerOutput {

    func didSelectAnswer(_ answer: Answer) {
        if didAnswerQuestion {
            return
        }

        didAnswerQuestion = true
        interactor?.didSelectAnswer(answer)

        viewController?.highlightAnswer(currentQuestion!.correctAnswer)

        if !answer.correct {
            viewController?.highlightAnswer(answer)
        }

        updateButtonLabel()
    }

}

extension QuizPresenter: QuizInteractorOutput {

    func fetchedNextQuestion(_ question: Question) {
        currentQuestion = question
        didAnswerQuestion = false

        viewController?.displayQuestion(question)

        updateStarIcon()
        updateButtonLabel()
    }

    func failedToFetchNextQuestion() {
        // TODO: Implement
    }

}
