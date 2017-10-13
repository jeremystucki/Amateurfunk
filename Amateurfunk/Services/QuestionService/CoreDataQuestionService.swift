import CoreData

class CoreDataQuestionService: QuestionService {

    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getMarkedQuestions(forChapters chapters: [Chapter]) throws -> [Question] {
        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "marked == YES AND chapter IN %@", chapters)

        return try context.fetch(query)
    }

    func getNumberOfMarkedQuestions(forChapters chapters: [Chapter]) throws -> Int {
        return try getMarkedQuestions(forChapters: chapters).count
    }

    private func getMinimumAmountOfCorrectAnswers(forChapters chapters: [Chapter]) throws -> Int {
        let key = "min"

        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = key
        expressionDescription.expression = NSExpression(format: "@min.timesAnsweredCorrectly")
        expressionDescription.expressionResultType = .integer16AttributeType

        let query = NSFetchRequest<NSDictionary>(entityName: Question.entity().name!)
        query.resultType = .dictionaryResultType
        query.propertiesToFetch = [expressionDescription]

        query.predicate = NSPredicate(format: "chapter IN %@", chapters)

        // swiftlint:disable:next force_cast
        return try context.fetch(query)[0].value(forKey: key) as! Int
    }

    func getQuestionForQuiz(fromChapters chapters: [Chapter]) throws -> Question {
        let min = try getMinimumAmountOfCorrectAnswers(forChapters: chapters)

        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "timesAnsweredCorrectly == %d AND chapter IN %@", min, chapters)

        let questions = try context.fetch(query)
        return questions.randomElement()
    }

    enum IamTooLazyToRefactorThisError: Error { case whatever } // TODO

    func getQuestionForQuiz(fromChapters chapters: [Chapter], withStreak streak: Int) throws -> Question {
        let query = Question.createFetchRequest()
        query.predicate = NSPredicate(format: "currentStreak == %d AND chapter IN %@", streak, chapters)

        let questions = try context.fetch(query)

        if questions.count == 0 {
            throw IamTooLazyToRefactorThisError.whatever
        }

        return questions.randomElement()
    }

    func registerChosenAnswer(_ answer: Answer) throws {
        let question = answer.question

        if answer.correct {
            question.currentStreak += 1
            question.timesAnsweredCorrectly += 1
        } else {
            question.currentStreak = 0
        }

        try context.save()
    }

    func markQuestion(_ question: Question) throws {
        question.marked = true

        try context.save()
    }

    func unmarkQuestion(_ question: Question) throws {
        question.marked = false

        try context.save()
    }

    // TODO: Deal with core data
    func getFlashcardsMetadata(forChapters chapters: [Chapter]) throws -> FlashcardsMetadata {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "count"
        expressionDescription.expression = NSExpression(format: "id.@count")
        expressionDescription.expressionResultType = .integer16AttributeType

        let currentStreakDescription = NSExpressionDescription()
        currentStreakDescription.name = "currentStreak"
        currentStreakDescription.expression = NSExpression(forKeyPath: "currentStreak")
        currentStreakDescription.expressionResultType = .integer16AttributeType

        let query = NSFetchRequest<NSDictionary>(entityName: Question.entity().name!)
        query.resultType = .dictionaryResultType
        query.propertiesToFetch = [currentStreakDescription, expressionDescription]
        query.propertiesToGroupBy = ["currentStreak"]

        query.predicate = NSPredicate(format: "chapter IN %@", chapters)

        let resultSet = try context.fetch(query)

        var metadata = FlashcardsMetadata()
        for element in resultSet {
            // swiftlint:disable force_cast
            metadata.append((streak: element.value(forKey: "currentStreak") as! Int,
                             count: element.value(forKey: "count") as! Int))
            // swiftlint:enable force_cast
        }

        return metadata
    }

}
