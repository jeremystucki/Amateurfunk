//
//  TestQuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

class TestQuestionService: QuestionService {

    let chapters = [Chapter(title: "test")]

    var count = 0

    func getNumberOfMarkedQuestions() throws -> Int {
        count += 1
        return count
    }

}
