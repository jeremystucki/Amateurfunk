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
}

protocol QuizInteractorOutput {
    func fetchedNextQuestion(_ question: Question)
    func failedToFetchNextQuestion()
}

class QuizInteractor {

    var presenter: QuizInteractorOutput?

    fileprivate let section: Section
    fileprivate let questionService: QuestionService
    fileprivate let chapterService: ChapterService

    init(section: Section, questionService: QuestionService, chapterService: ChapterService) {
        self.section = section
        self.questionService = questionService
        self.chapterService = chapterService
    }

}

extension QuizInteractor: QuizInteractorInput {

    func fetchNextQuestion() {
        do {
            let question = try questionService.getQuestionForQuiz(fromChapters: chapterService.getSeletedChapters(fromSection: section))
            presenter?.fetchedNextQuestion(question)
        } catch {
            presenter?.failedToFetchNextQuestion()
        }
    }

    // TODO: Review
    func didSelectAnswer(_ answer: Answer) {
        do {
            try questionService.registerChosenAnswer(answer)
        } catch { }
    }

}
