import CoreData

@objc(Section)
class Section: NSManagedObject, Decodable {

    @NSManaged var name: String
    @NSManaged var chapters: Set<Chapter>

    enum CodingKeys: String, CodingKey {
        case name = "section"
        case chapters = "chapters"
    }

    required init(from decoder: Decoder) throws {
        super.init(entity: Section.entity(), insertInto: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        chapters = try values.decode(Set<Chapter>.self, forKey: .chapters)
    }

}
