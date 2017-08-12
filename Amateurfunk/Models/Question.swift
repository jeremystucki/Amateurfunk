//
//  Question.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

@objc(Question)
class Question: NSManagedObject {

    @NSManaged var query: String
    @NSManaged var chapter: Chapter
    @NSManaged var answers: Set<Answer>

    @NSManaged var timesAnsweredCorrectly: Int16
    @NSManaged var currentStreak: Int16

}
