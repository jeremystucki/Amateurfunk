class FlashcardsQuestionProvider: QuestionProvider {

    private let section: Section
    private let services: QuizServices
    private let streak: Int

    init(section: Section, services: QuizServices, streak: Int) {
        self.section = section
        self.services = services
        self.streak = streak
    }

    func hasNext() throws -> Bool {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let question = try services.questionService.getQuestionForQuiz(fromChapters: chapters, withStreak: streak)

        return question != nil
    }

    func getNext() throws -> Question {
        let chapters = try services.chapterService.getSeletedChapters(fromSection: section)
        let question = try services.questionService.getQuestionForQuiz(fromChapters: chapters, withStreak: streak)

        return question!
    }

}
