import CoreData

extension NSFetchRequestResult where Self: NSManagedObject {

    static func createFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest<Self>(entityName: entity().name!)
    }

}
