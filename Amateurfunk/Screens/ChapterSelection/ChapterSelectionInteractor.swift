protocol ChapterSelectionInteractorInput {
    func fetchChapters()
    func fetchSelectedChapters()

    func updateSelectedChapters(selectedChapters: [Chapter])
}

protocol ChapterSelectionInteractorOutput {
    func fetchedChapters(_ chapters: [Chapter])
    func failedToFetchChapters()

    func fetchedSelectedChapters(_ selectedChapters: [Chapter])
    func failedToFetchSelectedChapters()

    func updatedSelectedChapters()
    func failedToUpdateSelectedChapters()
}

class ChapterSelectionInteractor {

    var presenter: ChapterSelectionInteractorOutput?

    private let section: Section
    private let services: ChapterSelectionServices

    init(section: Section, services: ChapterSelectionServices) {
        self.section = section
        self.services = services
    }

}

extension ChapterSelectionInteractor: ChapterSelectionInteractorInput {

    func fetchChapters() {
        do {
            let chapters = try services.chapterService.getAllChapters(fromSection: section)
            presenter?.fetchedChapters(chapters.sorted())
        } catch {
            presenter?.failedToFetchChapters()
        }
    }

    func fetchSelectedChapters() {
        do {
            let selectedChapters = try services.chapterService.getSeletedChapters(fromSection: section)
            presenter?.fetchedSelectedChapters(selectedChapters)
        } catch {
            presenter?.failedToFetchSelectedChapters()
        }
    }

    func updateSelectedChapters(selectedChapters: [Chapter]) {
        do {
            try services.chapterService.setSelectedChapters(selectedChapters, forSection: section)
            presenter?.updatedSelectedChapters()
        } catch {
            presenter?.failedToUpdateSelectedChapters()
        }
    }

}
