//
//  Section.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

@objc(Section)
class Section: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var chapters: [Chapter]

}
