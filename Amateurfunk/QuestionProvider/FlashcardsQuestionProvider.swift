class FlashcardsQuestionProvider: QuestionProvider {

    private let section: Section
    private let services: QuizServices
    private let streak: Int

    init(section: Section, services: QuizServices, streak: Int) {
        self.section = section
        self.services = services
        self.streak = streak
    }

    // TODO: Make less ugly
    func hasNext() throws -> Bool {
        do {
            let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
            _ = try services.questionService.getQuestionForQuiz(fromChapters: chapters, withStreak: streak)
            return true
        } catch {
            return false
        }
    }

    func getNext() throws -> Question {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let question = try services.questionService.getQuestionForQuiz(fromChapters: chapters, withStreak: streak)

        return question
    }

}
