//
//  Answer.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 05.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var correct: Bool

}

@objc(TextAnswer)
class TextAnswer: Answer {

    @NSManaged var answer: String

}
