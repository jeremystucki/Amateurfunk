typealias QuizServices = (chapterService: ChapterService, questionService: QuestionService)

class QuizQuestionProvider: QuestionProvider {

    private let section: Section
    private let services: QuizServices

    init(section: Section, services: QuizServices) {
        self.section = section
        self.services = services
    }

    func hasNext() throws -> Bool {
        return true
    }

    func getNext() throws -> Question {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let question = try services.questionService.getQuestionForQuiz(fromChapters: chapters)

        return question
    }

}
