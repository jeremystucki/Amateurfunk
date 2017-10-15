class MenuPresenter {

    var viewController: MenuViewControllerInput?
    var interactor: MenuInteractorInput?
    var router: MenuRouterInput?

}

extension MenuPresenter: MenuViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchNumberOfMarkedQuestions()
    }

    func didSelectChapterSelection() {
        router?.showChapterSelection()
    }

    func didSelectQuiz() {
        router?.showQuiz()
    }

    func didSelectFlashCards() {
        router?.showFlashcards()
    }

    func didSelectMarkedQuestions() {
        router?.showMarkedQuestions()
    }

    func didSelectExamMode() {
        router?.showExam()
    }

}

extension MenuPresenter: MenuInteractorOutput {

    func fetchedNumberOfMarkedQuestions(numberOfMarkedQuestions: Int) {
        if numberOfMarkedQuestions == 0 {
            viewController?.hideMarkedQuestions()
            return
        }

        viewController?.displayMarkedQuestions(numberOfMarkedQuestions: numberOfMarkedQuestions)
    }

    func failedToFetchNumberOfMarkedQuestions() {
        // TODO: Implement
    }

}
