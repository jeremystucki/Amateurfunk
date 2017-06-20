//
//  TestQuestionService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

//class TestQuestionService: QuestionService {
//
//    let chapters = [Chapter(title: "test")]
//
//    var count = 0
//
//    func getNumberOfMarkedQuestions() throws -> Int {
//        count += 1
//        return count
//    }
//
//    func getQuestionForQuiz() -> Question {
//        return Question(
//            query: "Test?",
//            answers: [
//                TextAnswer(answer: "1", correct: false),
//                TextAnswer(answer: "2", correct: true),
//                TextAnswer(answer: "3", correct: false)
//            ])
//    }
//
//    func registerChosenAnswer(_ answer: Answer) throws {
//        print("Chosen answer: \((answer as? TextAnswer)?.answer)")
//    }
//
//}
