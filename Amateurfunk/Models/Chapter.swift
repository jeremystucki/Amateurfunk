//
//  Chapter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

@objc(Chapter)
class Chapter: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var section: Section
    @NSManaged var questions: Set<Question>

    static func createFetchRequest() -> NSFetchRequest<Chapter> {
        return NSFetchRequest<Chapter>(entityName: "Chapter")
    }

}
