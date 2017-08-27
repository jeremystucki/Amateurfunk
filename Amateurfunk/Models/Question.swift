import CoreData

@objc(Question)
class Question: NSManagedObject {

    @NSManaged var query: String
    @NSManaged var chapter: Chapter
    @NSManaged var answers: Set<Answer>

    @NSManaged var marked: Bool

    @NSManaged var timesAnsweredCorrectly: Int16
    @NSManaged var currentStreak: Int16

}
