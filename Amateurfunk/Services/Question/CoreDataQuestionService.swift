//
//  CoreDataQuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 19.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class CoreDataQuestionService: QuestionService {

    fileprivate let chapters: [Chapter]
    fileprivate let context: NSManagedObjectContext

    init(chapters: [Chapter], context: NSManagedObjectContext) {
        self.chapters = chapters
        self.context = context
    }

    private func continuteToNextIteration() throws {
        chapters.forEach({ $0.current_iteration += 1 })

        try context.save()
    }

    func addQuestion(_ question: Question, chapter: Chapter) throws {
        question.chapter = chapter
        context.insert(question)

        try context.save()
    }

    func getNextQuestion() throws -> Question {
        let currentIteration = chapters.reduce(0, { min($0, $1.current_iteration) })

        let query: NSFetchRequest<Question> = Question.fetchRequest()
        query.predicate = NSPredicate(format: "question.times_answered_correctly == %@", argumentArray: [currentIteration])
        query.fetchLimit = 1

        let questions = try context.fetch(query)
        if questions.count != 0 {
            return questions[0]
        }

        try continuteToNextIteration()

        return try getNextQuestion() // This wont cause an infinite loop as each chapter is required to have at least one question
    }

    func answered(question: Question, correctly answeredCorrectly: Bool) throws {
        if answeredCorrectly {
            question.times_answered_correctly += 1
        } else {
            question.times_answered_incorrectly += 1
        }

        try context.save()
    }

}
