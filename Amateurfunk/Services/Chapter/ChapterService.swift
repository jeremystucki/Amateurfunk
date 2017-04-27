//
//  ChapterService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol ChapterService {

    func fetchChapters() throws -> [Chapter]

}
