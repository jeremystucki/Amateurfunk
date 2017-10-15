class ExamPresenter {

    var viewController: ExamViewControllerInput?
    var interactor: ExamInteractorInput?
    var router: ExamRouterInput?

}

extension ExamPresenter: ExamViewControllerOutput {

    func didSelectStart() {
        router?.startExam()
    }

}

extension ExamPresenter: ExamInteractorOutput {

}
