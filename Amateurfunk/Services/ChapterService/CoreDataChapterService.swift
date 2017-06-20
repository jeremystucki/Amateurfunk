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

    init(context: NSManagedObjectContext, chapters: [Chapter]) {
        self.context = context
    }

    func getAllChapters() throws -> [Chapter] {
        let query = Chapter.createFetchRequest()
        return try context.fetch(query)
    }

    func getSeletedChapters() throws -> [Chapter] {
        return try getAllChapters()
    }

    func setSelectedChapters(_ selectedChapters: [Chapter]) throws {
        // TODO
    }

}
