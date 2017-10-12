protocol FlashcardsInteractorInput {
    func fetchFlashcardsMetadata()
}

protocol FlashcardsInteractorOutput {
    func fetchedFlashcardsMetadata(_ metadata: FlashcardsMetadata)
    func failedTofetchFlashcardsMetadata()
}

class FlashcardsInteractor {

    var presenter: FlashcardsInteractorOutput?

    private let section: Section
    private let services: FlashcardsServices

    init(section: Section, services: FlashcardsServices) {
        self.section = section
        self.services = services
    }

}

extension FlashcardsInteractor: FlashcardsInteractorInput {

    func fetchFlashcardsMetadata() {
        do {
            let selectedChapters = try services.chapterService.getSeletedChapters(fromSection: section)
            let flashcardsMetadata = try services.questionService.getFlashcardsMetadata(forChapters: selectedChapters)

            presenter?.fetchedFlashcardsMetadata(flashcardsMetadata)
        } catch {
            presenter?.failedTofetchFlashcardsMetadata()
        }
    }

}
