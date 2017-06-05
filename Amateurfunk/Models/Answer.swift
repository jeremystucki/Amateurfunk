//
//  Answer.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 05.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

// TODO: DisplayableAnswer does not belong here
protocol Answer: DisplayableAnswer {

}

struct TextAnswer: Answer {

    let answer: String

}
