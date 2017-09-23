import Foundation

protocol SetttingsInteractorInput {
    func resetData()
}

protocol SetttingsInteractorOutput {
    func dataResetSuccessfully()
    func dataResetUnsuccessfully()
}

class SetttingsInteractor {

    var presenter: SetttingsInteractorOutput?

    private let dataloaderService: DataloaderService

    init(dataloaderService: DataloaderService) {
        self.dataloaderService = dataloaderService
    }

}

extension SetttingsInteractor: SetttingsInteractorInput {

    func resetData() {
        let technik = Bundle.main.resourceURL!.appendingPathComponent("bakom_technik.json")
        let vorschriften = Bundle.main.resourceURL!.appendingPathComponent("bakom_vorschriften.json")

        do {
            try dataloaderService.loadData(technik: technik, vorschriften: vorschriften)
            presenter?.dataResetSuccessfully()
        } catch {
            presenter?.dataResetUnsuccessfully()
        }
    }

}
