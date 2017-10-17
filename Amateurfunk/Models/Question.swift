import CoreData

@objc(Question)
class Question: NSManagedObject, Decodable {

    // swiftlint:disable:next identifier_name
    @NSManaged var id: String
    @NSManaged var query: String
    @NSManaged var chapter: Chapter
    @NSManaged var answers: Set<Answer>

    @NSManaged var marked: Bool

    @NSManaged var timesAnsweredCorrectly: Int16
    @NSManaged var currentStreak: Int16

    var correctAnswer: Answer! {
        return answers.first(where: { $0.correct })
    }

    enum CodingKeys: String, CodingKey {
        // swiftlint:disable:next identifier_name
        case id = "id"
        case query = "question"
        case answers = "answers"
    }

    required init(from decoder: Decoder) throws {
        super.init(entity: Question.entity(), insertInto: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        query = try values.decode(String.self, forKey: .query)
        answers = try values.decode(Set<TextAnswer>.self, forKey: .answers)
    }

}

extension Question: Comparable {

    public static func < (lhs: Question, rhs: Question) -> Bool {
        return lhs.id.compare(rhs.id, options: .numeric) == .orderedAscending
    }

}
