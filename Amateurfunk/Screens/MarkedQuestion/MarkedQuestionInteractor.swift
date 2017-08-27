protocol MarkedQuestionInteractorInput {
    func didSelectAnswer(_ answer: Answer)

    func removeMarkedQuestion(_ question: Question)
    func addMarkedQuestion(_ question: Question)
}

protocol MarkedQuestionInteractorOutput {
    // TODO: Error handling
}

class MarkedQuestionInteractor {

    var presenter: MarkedQuestionInteractorOutput?

    private let questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

}

extension MarkedQuestionInteractor: MarkedQuestionInteractorInput {

    func didSelectAnswer(_ answer: Answer) {
        do {
            try questionService.registerChosenAnswer(answer)
        } catch { }
    }

    func removeMarkedQuestion(_ question: Question) {
        do {
            try questionService.markQuestion(question)
        } catch { }
    }

    func addMarkedQuestion(_ question: Question) {
        do {
            try questionService.unmarkQuestion(question)
        } catch { }
    }

}
