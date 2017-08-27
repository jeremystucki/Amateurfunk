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
