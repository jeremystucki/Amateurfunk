typealias MarkedQuestionServices = (chapterService: ChapterService, questionService: QuestionService)

class MarkedQuestionProvider: QuestionProvider {

    private let section: Section
    private let services: MarkedQuestionServices

    private var atFirstQuestion: Bool = true
    private var currentQuestion: Question

    init(section: Section, services: MarkedQuestionServices, startAt question: Question) {
        self.section = section
        self.services = services

        self.currentQuestion = question
    }

    func hasNext() throws -> Bool {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let questions = try services.questionService.getMarkedQuestions(forChapters: chapters)

        return questions.count != 0
    }

    func getNext() throws -> Question {
        if atFirstQuestion {
            atFirstQuestion = false
            return currentQuestion
        }

        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let questions = try services.questionService.getMarkedQuestions(forChapters: chapters).sorted()

        currentQuestion = questions.first(where: { $0 > self.currentQuestion }) ?? questions.first!

        return currentQuestion
    }

}
