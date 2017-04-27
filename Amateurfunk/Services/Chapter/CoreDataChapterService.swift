//
//  CoreDataChapterService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 12.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class CoreDataChapterService: ChapterService {

    fileprivate let section: Section
    fileprivate let context: NSManagedObjectContext

    init(section: Section, context: NSManagedObjectContext) {
        self.section = section
        self.context = context
    }

    func fetchChapters() throws -> [Chapter] {
        let query: NSFetchRequest<Chapter> = Chapter.fetchRequest()

        // TODO: Replace with object comparison instead of name comparison
        query.predicate = NSPredicate(format: "section.name == %@", argumentArray: [section.name!])

        return try context.fetch(query)
    }

}
