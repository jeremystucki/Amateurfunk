//
//  QuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol QuestionService {

    var chapters: [Chapter] { get }

    func getNumberOfMarkedQuestions() throws -> Int

    // TODO: Rename
    func getQuestionForQuerying() throws -> Question

}
