class MarkedQuestionsPresenter {

    var viewController: MarkedQuestionsViewControllerInput?
    var interactor: MarkedQuestionsInteractorInput?
    var router: MarkedQuestionsRouterInput?

}

extension MarkedQuestionsPresenter: MarkedQuestionsViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchMarkedQuestions()
    }

    func didSelectQuestion(_ question: Question) {
        router?.showQuestion(question)
    }

}

extension MarkedQuestionsPresenter: MarkedQuestionsInteractorOutput {

    func fetchedMarkedQuestions(_ questions: [Question]) {
        if questions.count == 0 {
            router?.dismissView()
        } else {
            viewController?.displayQuestions(questions.sorted())
        }
    }

    func failedToFetchMarkedQuestions() {
        // TODO: Implement
    }

}
