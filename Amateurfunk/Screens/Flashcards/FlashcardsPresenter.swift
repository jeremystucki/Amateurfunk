class FlashcardsPresenter {

    var viewController: FlashcardsViewControllerInput?
    var interactor: FlashcardsInteractorInput?
    var router: FlashcardsRouterInput?

}

extension FlashcardsPresenter: FlashcardsViewControllerOutput {

    func viewWillAppear() {
        interactor?.fetchFlashcardsMetadata()
    }

    func didSelectStreak(_ streak: Int) {
        router?.showQuestionsForStreak(streak)
    }

}

extension FlashcardsPresenter: FlashcardsInteractorOutput {

    func fetchedFlashcardsMetadata(_ metadata: FlashcardsMetadata) {
        viewController?.displayFlashcardsMetadata(metadata)
    }

    func failedTofetchFlashcardsMetadata() {
        // TODO
    }

}
