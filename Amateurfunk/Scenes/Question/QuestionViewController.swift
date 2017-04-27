//
//  QuestionViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 17.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QuestionViewControllerInput {

}

protocol QuestionViewControllerOutput {
    func viewInitialized()
}

class QuestionViewController: UITableViewController {

    var output: QuestionViewControllerOutput?

    var question: [Chapter]?

    init() {
        super.init(style: .grouped)
    }

    override func viewDidLoad() {
        output?.viewInitialized()
        super.viewDidLoad()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QuestionViewController: QuestionViewControllerInput {

}
