protocol MarkedQuestionInteractorInput {
}

protocol MarkedQuestionInteractorOutput {
}

class MarkedQuestionInteractor {

    var presenter: MarkedQuestionInteractorOutput?

    private let questionService: QuestionService

    init(questionService: QuestionService) {
        self.questionService = questionService
    }

}

extension MarkedQuestionInteractor: MarkedQuestionInteractorInput {

}
