//
//  QuizInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QuizInteractorInput {
    func fetchNextQuestion()

    func didSelectAnswer(_ answer: Answer)

    func removeMarkedQuestion(_ question: Question)
    func addMarkedQuestion(_ question: Question)
}

protocol QuizInteractorOutput {
    func fetchedNextQuestion(_ question: Question)
    func failedToFetchNextQuestion()
}

class QuizInteractor {

    var presenter: QuizInteractorOutput?

    private let section: Section
    private let services: QuizServices

    init(section: Section, services: QuizServices) {
        self.section = section
        self.services = services
    }

}

extension QuizInteractor: QuizInteractorInput {

    func fetchNextQuestion() {
        do {
            let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
            let question = try services.questionService.getQuestionForQuiz(fromChapters: chapters)
            presenter?.fetchedNextQuestion(question)
        } catch {
            presenter?.failedToFetchNextQuestion()
        }
    }

    func didSelectAnswer(_ answer: Answer) {
        do {
            try services.questionService.registerChosenAnswer(answer)
        } catch { }
    }

    func removeMarkedQuestion(_ question: Question) {
        do {
            try services.questionService.markQuestion(question)
        } catch { }
    }

    func addMarkedQuestion(_ question: Question) {
        do {
            try services.questionService.unmarkQuestion(question)
        } catch { }
    }

}
