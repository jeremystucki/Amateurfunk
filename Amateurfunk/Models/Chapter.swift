import Foundation
import CoreData

@objc(Chapter)
class Chapter: NSManagedObject, Decodable {

    @NSManaged var title: String
    @NSManaged var section: Section
    @NSManaged var questions: Set<Question>
    @NSManaged var selected: Bool

    enum CodingKeys: String, CodingKey {
        case title = "chapter"
        case questions = "questions"
    }

    required convenience init(from decoder: Decoder) throws {
        self.init(entity: Chapter.entity(), insertInto: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        questions = try values.decode(Set<Question>.self, forKey: .questions)
    }

}

extension Chapter: Comparable {

    public static func < (lhs: Chapter, rhs: Chapter) -> Bool {
        return lhs.title.localizedStandardCompare(rhs.title) == .orderedAscending
    }

}
