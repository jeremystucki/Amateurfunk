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
