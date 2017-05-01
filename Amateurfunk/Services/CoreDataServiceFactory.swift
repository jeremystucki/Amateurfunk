//
//  CoreDataServiceFactory.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 01.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class CoreDataServiceFactory {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

}

extension CoreDataServiceFactory: ServiceFactory {

    func getChapterService(forSection section: Section) -> ChapterService {
        return CoreDataChapterService(section: section, context: context)
    }

    func getQuestionService(forChapters chapters: [Chapter]) -> QuestionService {
        return CoreDataQuestionService(chapters: chapters, context: context)
    }

}
