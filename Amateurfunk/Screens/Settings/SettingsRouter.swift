import UIKit

protocol SetttingsRouterInput {

}

class SetttingsRouter {

    var viewController: UIViewController?

    private let dataloaderService: DataloaderService

    init(dataloaderService: DataloaderService) {
        self.dataloaderService = dataloaderService
    }

    static func setupModule(dataloaderService: DataloaderService) -> UIViewController {
        let viewController = SetttingsViewController()
        let interactor = SetttingsInteractor(dataloaderService: dataloaderService)
        let presenter = SetttingsPresenter()

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor

        let router = SetttingsRouter(dataloaderService: dataloaderService)

        presenter.router = router
        router.viewController = viewController

        return viewController
    }

}

extension SetttingsRouter: SetttingsRouterInput {

}
