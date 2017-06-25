//
//  CoreDataChapterService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class CoreDataChapterService: ChapterService {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getAllChapters() throws -> [Chapter] {
        let query = Chapter.createFetchRequest()

        return try context.fetch(query)
    }

    func getSeletedChapters() throws -> [Chapter] {
        let query = Chapter.createFetchRequest()
        query.predicate = NSPredicate(format: "selected == YES")

        return try context.fetch(query)
    }

    func setSelectedChapters(_ selectedChapters: [Chapter]) throws {
        for chapter in try getAllChapters() {
            chapter.selected = false
        }

        for chapter in selectedChapters {
            chapter.selected = true
        }

        try context.save()
    }

}
