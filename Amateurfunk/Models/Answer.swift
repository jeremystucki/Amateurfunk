import CoreData

@objc(Answer)
class Answer: NSManagedObject {

    @NSManaged var correct: Bool
    @NSManaged var question: Question

}

@objc(TextAnswer)
class TextAnswer: Answer {

    @NSManaged var answer: String

}
