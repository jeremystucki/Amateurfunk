//
//  QuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QuestionService {

    func getMarkedQuestions(forChapters chapters: [Chapter]) throws -> [Question]
    func getNumberOfMarkedQuestions(forChapters chapters: [Chapter]) throws -> Int

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question
    func registerChosenAnswer(_ answer: Answer) throws

    func markQuestion(_ question: Question) throws
    func unmarkQuestion(_ question: Question) throws

}
