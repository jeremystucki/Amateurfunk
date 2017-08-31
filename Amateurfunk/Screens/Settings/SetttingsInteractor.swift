protocol SetttingsInteractorInput {

}

protocol SetttingsInteractorOutput {

}

class SetttingsInteractor {

    var presenter: SetttingsInteractorOutput?

    private let services: SetttingsServices

    init(services: SetttingsServices) {
        self.services = services
    }

}

extension SetttingsInteractor: SetttingsInteractorInput {

}
