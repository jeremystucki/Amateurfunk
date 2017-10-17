import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var correct: Bool
    @NSManaged var question: Question

}

@objc(TextAnswer)
class TextAnswer: Answer, Decodable {

    @NSManaged var answer: String

    enum CodingKeys: String, CodingKey {
        case answer
        case correct
    }

    required init(from decoder: Decoder) throws {
        super.init(entity: TextAnswer.entity(), insertInto: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decode(String.self, forKey: .answer)
        correct = try values.decode(Bool.self, forKey: .correct)
    }

}
