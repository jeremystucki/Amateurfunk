//
//  ChapterService.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

protocol ChapterService {

    func getAllChapters() throws -> [Chapter]

    func getSeletedChapters() throws -> [Chapter]
    func setSelectedChapters(_ selectedChapters: [Chapter]) throws

}
