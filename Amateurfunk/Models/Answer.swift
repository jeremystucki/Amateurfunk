//
//  Answer.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 05.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

@objc(Answer)
protocol Answer {

     var correct: Bool { get set }

}

@objc(TextAnswer)
class TextAnswer: NSManagedObject, Answer {

    @NSManaged var correct: Bool
    @NSManaged var answer: String

}
