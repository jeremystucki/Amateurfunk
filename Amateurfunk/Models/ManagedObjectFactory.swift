//
//  ManagedObjectFactory.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import CoreData

class ManagedObjectFactory<T: NSManagedObject> {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func create() -> T {
        return T(entity: T.entity(), insertInto: context)
    }

}
