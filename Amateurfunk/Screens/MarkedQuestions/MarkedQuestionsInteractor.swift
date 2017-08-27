protocol MarkedQuestionsInteractorInput {
    func fetchMarkedQuestions()
}

protocol MarkedQuestionsInteractorOutput {
    func fetchedMarkedQuestions(_ questions: [Question])
    func failedToFetchMarkedQuestions()
}

class MarkedQuestionsInteractor {

    var presenter: MarkedQuestionsInteractorOutput?

    private let section: Section
    private let services: MarkedQuestionsServices

    init(section: Section, services: MarkedQuestionsServices) {
        self.section = section
        self.services = services
    }

}

extension MarkedQuestionsInteractor: MarkedQuestionsInteractorInput {

    func fetchMarkedQuestions() {
        do {
            let selectedChapters = try services.chapterService.getSeletedChapters(fromSection: section)
            let markedQuestions = try services.questionService.getMarkedQuestions(forChapters: selectedChapters)

            presenter?.fetchedMarkedQuestions(markedQuestions)
        } catch {
            presenter?.failedToFetchMarkedQuestions()
        }
    }

}
