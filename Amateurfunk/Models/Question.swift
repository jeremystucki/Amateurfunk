//
//  Question.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 03.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class Question: NSManagedObject {

    @NSManaged var query: String
    @NSManaged var chapter: Chapter
    @NSManaged var answers: [Answer]

}
