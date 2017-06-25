//
//  QuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QuestionService {

    func getNumberOfMarkedQuestions(fromSection section: Section) throws -> Int

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question
    func registerChosenAnswer(_ answer: Answer) throws

}
