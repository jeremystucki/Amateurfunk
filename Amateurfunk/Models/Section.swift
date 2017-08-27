import CoreData

@objc(Section)
class Section: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var chapters: Set<Chapter>

}
