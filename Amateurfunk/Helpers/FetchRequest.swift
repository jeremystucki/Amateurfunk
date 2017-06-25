//
//  FetchRequest.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 25.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

extension NSFetchRequestResult where Self: NSManagedObject {

    static func createFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest<Self>(entityName: entity().name!)
    }

}
