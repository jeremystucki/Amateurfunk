//
//  QuizPresenter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class QuizPresenter {

    var viewController: QuizViewControllerInput?
    var interactor: QuizInteractorInput?
    var router: QuizRouterInput?

    var currentQuestion: Question?
    var questionViewController: QuestionViewControllerInput?

    var didAnswerQuestion = false

    fileprivate func highlightCorrectAnswer() {
        let correctAnswer = currentQuestion!.answers.first { $0.correct }!
        questionViewController?.highlightAnswer(answer: correctAnswer, withColor: .green)
    }

}

extension QuizPresenter: QuizViewControllerOutput {

    func viewDidLoad() {
        interactor?.fetchNextQuestion()
    }

    func didSelectNextQuestion() {
        interactor?.fetchNextQuestion()
    }

    func didSelectShowAnswer() {
        didAnswerQuestion = true
        highlightCorrectAnswer()

        viewController?.showButtonState(.nextQuestion)
    }

    func starClicked() {
        if currentQuestion!.marked {
            interactor?.removeMarkedQuestion(currentQuestion!)
            viewController?.showEmptyStar()
        } else {
            interactor?.addMarkedQuestion(currentQuestion!)
            viewController?.showFullStar()
        }

        currentQuestion!.marked = !currentQuestion!.marked
    }

}

extension QuizPresenter: QuestionViewControllerOutput {

    func didSelectAnswer(_ answer: Answer) {
        if didAnswerQuestion {
            return
        }

        didAnswerQuestion = true
        highlightCorrectAnswer()

        if !answer.correct {
            questionViewController?.highlightAnswer(answer: answer, withColor: .orange)
        }

        viewController?.showButtonState(.nextQuestion)
        interactor?.didSelectAnswer(answer)
    }

}

extension QuizPresenter: QuizInteractorOutput {

    func fetchedNextQuestion(_ question: Question) {
        currentQuestion = question

        questionViewController = QuestionViewController(question: question, presenter: self)
        viewController?.displayQuestion(questionViewController!.view)

        didAnswerQuestion = false
        viewController?.showButtonState(.showAnswer)

        if question.marked {
            viewController?.showFullStar()
        } else {
            viewController?.showEmptyStar()
        }
    }

    func failedToFetchNextQuestion() {
        // Do nothing
    }

}
