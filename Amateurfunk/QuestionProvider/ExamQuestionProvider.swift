typealias ExamQuestionServices = (chapterService: ChapterService, questionService: QuestionService)

class ExamQuestionProvider: QuestionProvider {

    private let questions: [Question]
    private var currentQuestion = -1 // TODO: Fix

    init(section: Section, services: ExamQuestionServices) throws {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        self.questions = try services.questionService.getQuestionsForExam(fromChapters: chapters, numberOfQuestions: 20)
    }

    func hasNext() throws -> Bool {
        return questions.count > currentQuestion + 1
    }

    func getNext() throws -> Question {
        currentQuestion += 1
        return questions[currentQuestion]
    }

}
