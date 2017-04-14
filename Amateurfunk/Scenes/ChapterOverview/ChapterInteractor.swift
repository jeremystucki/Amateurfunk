//
//  ChapterInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 12.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

protocol ChapterInteractorInput {
    func fetchChapters()

    func addChapter(_ chapter: Chapter)
}

protocol ChapterInteractorOutput {
    func fetchedChapters(_ chapters: [Chapter])
    func failedToFetchChapters()

    func addedChapter(_ chapter: Chapter)
    func failedToAddChapter(_ chapter: Chapter)
}

class ChapterInteractor {

    var output: ChapterInteractorOutput?

    fileprivate let section: Section
    fileprivate let context: NSManagedObjectContext

    init(section: Section, context: NSManagedObjectContext) {
        self.section = section
        self.context = context
    }

}

extension ChapterInteractor: ChapterInteractorInput {

    func fetchChapters() {
        let query: NSFetchRequest<Chapter> = Chapter.fetchRequest()

        // TODO: Replace with object comparison instead of name comparison
        query.predicate = NSPredicate(format: "section.name == %@", argumentArray: [section.name!])

        do {
            let results = try context.fetch(query)
            output?.fetchedChapters(results)
        } catch {
            output?.failedToFetchChapters()
        }
    }

    func addChapter(_ chapter: Chapter) {
        chapter.section = section
        context.insert(chapter)

        do {
            try context.save()

            output?.addedChapter(chapter)
            return
        } catch {
            output?.failedToAddChapter(chapter)
        }
    }

}
