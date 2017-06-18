//
//  Question.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

struct Question {

    let query: String

    let answers: [Answer]

}

extension Question: Equatable {

    public static func==(lhs: Question, rhs: Question) -> Bool {
        // TODO: Fix
        return lhs.query == rhs.query
    }

}
