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

    fileprivate let section: Section
    fileprivate let chapterService: ChapterService
    fileprivate let questionService: QuestionService

    init(section: Section, chapterService: ChapterService, questionService: QuestionService) {
        self.section = section
        self.chapterService = chapterService
        self.questionService = questionService
    }

    static func setupModule(section: Section,
                            chapterService: ChapterService,
                            questionService: QuestionService) -> UIViewController {
        let viewController = MenuViewController(title: section.name)
        let interactor = MenuInteractor(section: section,
                                        chapterService: chapterService,
                                        questionService: questionService)
        let presenter = MenuPresenter()
        let router = MenuRouter(section: section, chapterService: chapterService, questionService: questionService)

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
        let view = ChapterSelectionRouter.setupModule(section: section,
                                                      chapterService: chapterService,
                                                      questionService: questionService)
        let vc = UINavigationController(rootViewController: view)

        if #available(iOS 11.0, *) {
            vc.navigationBar.prefersLargeTitles = true
        }

        viewController?.present(vc, animated: true, completion: nil)
    }

    func showQuiz() {
        let view = QuizRouter.setupModule(section: section,
                                          questionService: questionService,
                                          chapterService: chapterService)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }

}
