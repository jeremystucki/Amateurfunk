//
//  CoreDataQuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class CoreDataQuestionService: QuestionService {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getNumberOfMarkedQuestions(forChapters chapters: [Chapter]) throws -> Int {
        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "marked == YES AND chapter IN %@", chapters)

        let questions = try context.fetch(query)

        // swiftlint:disable:next force_cast
        return questions.count
    }

    private func getMinimumAmountOfCorrectAnswers(forChapters chapters: [Chapter]) throws -> Int {
        let key = "min"

        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = key
        expressionDescription.expression = NSExpression(format: "@min.timesAnsweredCorrectly")
        expressionDescription.expressionResultType = .integer16AttributeType

        let request = NSFetchRequest<NSDictionary>(entityName: Question.entity().name!)
        request.resultType = .dictionaryResultType
        request.propertiesToFetch = [expressionDescription]

        request.predicate = NSPredicate(format: "chapter IN %@", chapters)

        // swiftlint:disable:next force_cast
        return try context.fetch(request)[0].value(forKey: key) as! Int
    }

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question {
        let min = try getMinimumAmountOfCorrectAnswers(forChapters: chapters)

        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "timesAnsweredCorrectly == %d AND chapter IN %@", min, chapters)

        let questions = try context.fetch(query)
        let question = questions.randomElement()

        print(question)
        return question
    }

    func registerChosenAnswer(_ answer: Answer) throws {
        let question = answer.question

        if answer.correct {
            question.currentStreak += 1
            question.timesAnsweredCorrectly += 1
        } else {
            question.currentStreak = 0
        }

        try context.save()
    }

    func markQuestion(_ question: Question) throws {
        question.marked = true

        try context.save()
    }

    func unmarkQuestion(_ question: Question) throws {
        question.marked = false

        try context.save()
    }

}
