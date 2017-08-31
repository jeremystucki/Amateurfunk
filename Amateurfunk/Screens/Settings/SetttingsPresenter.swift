class SetttingsPresenter {

    var viewController: SetttingsViewControllerInput?
    var interactor: SetttingsInteractorInput?
    var router: SetttingsRouterInput?

}

extension SetttingsPresenter: SetttingsViewControllerOutput {

    func didSelectReset() {
        viewController?.askForResetConfirmation()
    }

    func didPressConfirm() {
        // TODO
    }

    func didPressCancel() {
        // Do nothing
    }

}

extension SetttingsPresenter: SetttingsInteractorOutput {

}
