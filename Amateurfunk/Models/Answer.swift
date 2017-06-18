//
//  Answer.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 05.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

// TODO: Refactor
protocol Answer: DisplayableAnswer {

    var correct: Bool { get }

}

struct TextAnswer: Answer {

    let answer: String
    let correct: Bool

}
