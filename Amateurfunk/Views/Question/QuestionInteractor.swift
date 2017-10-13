import Foundation

protocol QuestionInteractorInput {
    func fetchNextQuestion()
    func fetchHasNextQuestion()

    func registerChosenAnswer(_ answer: Answer)

    func removeMarkedQuestion(_ question: Question)
    func addMarkedQuestion(_ question: Question)
}

protocol QuestionInteractorOutput {
    func fetchedQuestion(_ question: Question)
    func failedToFetchNextQuestion()

    func fetchedHasNextQuestion(_ hasNextQuestion: Bool)
    func failedToFetchHasNextQuestion()
}

class QuestionInteractor {

    var presenter: QuestionInteractorOutput?

    private let questionProvider: QuestionProvider
    private let questionService: QuestionService

    init(questionProvider: QuestionProvider, questionService: QuestionService) {
        self.questionProvider = questionProvider
        self.questionService = questionService
    }

}

extension QuestionInteractor: QuestionInteractorInput {

    func fetchNextQuestion() {
        do {
            let question = try questionProvider.getNext()
            presenter?.fetchedQuestion(question)
        } catch {
            presenter?.failedToFetchNextQuestion()
        }
    }

    func fetchHasNextQuestion() {
        do {
            let hasNextQuestion = try questionProvider.hasNext()
            presenter?.fetchedHasNextQuestion(hasNextQuestion)
        } catch {
            presenter?.failedToFetchHasNextQuestion()
        }
    }

    func registerChosenAnswer(_ answer: Answer) {
        do {
            try questionService.registerChosenAnswer(answer)
        } catch { }
    }

    func removeMarkedQuestion(_ question: Question) {
        do {
            try questionService.unmarkQuestion(question)
        } catch { }
    }

    func addMarkedQuestion(_ question: Question) {
        do {
            try questionService.markQuestion(question)
        } catch { }
    }

}
