import Foundation

class ChapterSelectionPresenter {

    var viewController: ChapterSelectionViewControllerInput?
    var interactor: ChapterSelectionInteractorInput?
    var router: ChapterSelectionRouterInput?

}

extension ChapterSelectionPresenter: ChapterSelectionViewControllerOutput {

    func viewDidLoad() {
        interactor?.fetchChapters()
        interactor?.fetchSelectedChapters()
    }

    func didClickCancel() {
        router?.dismissView()
    }

    func didClickDone(withSelectedChapters selectedChapters: [Chapter]) {
        if selectedChapters.count == 0 {
            viewController?.displayError(withMessage: "Mindestens ein Kapitel muss ausgewählt sein.")
            return
        }

        interactor?.updateSelectedChapters(selectedChapters: selectedChapters)
    }

}

extension ChapterSelectionPresenter: ChapterSelectionInteractorOutput {

    func fetchedChapters(_ chapters: [Chapter]) {
        viewController?.displayChapters(chapters)
    }

    func failedToFetchChapters() {
        // TODO: Implement
    }

    func fetchedSelectedChapters(_ selectedChapters: [Chapter]) {
        viewController?.displaySelectedChapters(selectedChapters)
    }

    func failedToFetchSelectedChapters() {
        // TODO: Implement
    }

    func updatedSelectedChapters() {
        router?.dismissView()
    }

    func failedToUpdateSelectedChapters() {
        viewController?.displayError(withMessage: "Ein interner Fehler ist aufgetreten.")
    }

}
