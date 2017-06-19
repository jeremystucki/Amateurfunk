//
//  MenuRouter.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 28.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol MenuRouterInput {
    func showChapterSelection()
    func showQuiz()
}

class MenuRouter {

    var viewController: UIViewController?

    fileprivate let chapterService: ChapterService
    fileprivate let questionService: QuestionService

    init(chapterService: ChapterService, questionService: QuestionService) {
        self.chapterService = chapterService
        self.questionService = questionService
    }

    static func setupModule(title: String,
                            chapterService: ChapterService,
                            questionService: QuestionService) -> UIViewController {
        let viewController = MenuViewController(title: title)
        let interactor = MenuInteractor(questionService: questionService)
        let presenter = MenuPresenter()
        let router = MenuRouter(chapterService: chapterService, questionService: questionService)

        router.viewController = viewController

        viewController.presenter = presenter
        interactor.presenter = presenter

        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.router = router

        return viewController
    }

}

extension MenuRouter: MenuRouterInput {

    func showChapterSelection() {
        let view = ChapterSelectionRouter.setupModule(chapterService: chapterService, questionService: questionService)

        viewController?.present(UINavigationController(rootViewController: view), animated: true, completion: nil)
    }

    func showQuiz() {
        let view = QuizRouter.setupModule(questionService: questionService)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }

}
