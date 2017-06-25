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

    func getNumberOfMarkedQuestions(fromSection section: Section) throws -> Int {
        return 0
    }

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question {
        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "chapter IN %@", chapters)

        let questions = try context.fetch(query)
        return questions.randomElement()
    }

    func registerChosenAnswer(_ answer: Answer) throws {
        // TODOInt(arc4random_uniform(UInt32(array.count)))
    }

}
