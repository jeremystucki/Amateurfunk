//
//  ServiceFactory.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 01.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

protocol ServiceFactory {

    func getChapterService(forSection section: Section) -> ChapterService

    func getQuestionService(forChapters chapters: [Chapter]) -> QuestionService

}
