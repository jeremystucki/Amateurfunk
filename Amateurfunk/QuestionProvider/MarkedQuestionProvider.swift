typealias MarkedQuestionServices = (chapterService: ChapterService, questionService: QuestionService)

class MarkedQuestionProvider: QuestionProvider {

    private let questions: [Question]
    private var currentQuestionIndex: Int

    // TODO: Do not load all questions at once
    init(section: Section, services: MarkedQuestionServices, startAt question: Question) throws {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        self.questions = try services.questionService.getMarkedQuestions(forChapters: chapters)

        currentQuestionIndex = questions.index(of: question)! - 1 // TODO
    }

    func hasNext() throws -> Bool {
        return true
    }

    func getNext() throws -> Question {
        currentQuestionIndex += 1

        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }

        return questions[currentQuestionIndex]
    }

}
