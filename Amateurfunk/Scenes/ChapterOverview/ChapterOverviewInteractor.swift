//
//  ChapterOverviewInteractor.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 17.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

protocol ChapterOverviewInteractorInput {
    func fetchChapters()
}

protocol ChapterOverviewInteractorOutput {
    func fetchedChapters(_ chapters: [Chapter])
    func failedToFetchChapters()
}

class ChapterOverviewInteractor {

    var output: ChapterOverviewInteractorOutput?

    fileprivate let chapterService: ChapterService

    init(chapterService: ChapterService) {
        self.chapterService = chapterService
    }

}

extension ChapterOverviewInteractor: ChapterOverviewInteractorInput {

    func fetchChapters() {
        do {
            let chapters = try chapterService.fetchChapters()
            output?.fetchedChapters(chapters)
        } catch {
            output?.failedToFetchChapters()
        }
    }

}
