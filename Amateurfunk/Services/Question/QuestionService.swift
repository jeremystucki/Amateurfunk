//
//  QuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QuestionService {

    func addQuestion(_ question: Question, chapter: Chapter) throws

    func getNextQuestion() throws -> Question

}
