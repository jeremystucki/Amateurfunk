//
//  Chapter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation
import CoreData

@objc(Chapter)
class Chapter: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var section: Section
    @NSManaged var questions: Set<Question>
    @NSManaged var selected: Bool

}

extension Chapter: Comparable {

    public static func < (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending
    }

}
