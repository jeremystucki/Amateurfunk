//
//  Chapter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

struct Chapter {

    let title: String

}

extension Chapter: Equatable {

    public static func==(lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.title == rhs.title
    }

}
