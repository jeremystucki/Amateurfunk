protocol ExamInteractorInput {

}

protocol ExamInteractorOutput {

}

class ExamInteractor {

    var presenter: ExamInteractorOutput?

}

extension ExamInteractor: ExamInteractorInput {

}
