//
//  QueryingViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QueryingViewControllerInput {
    func displayQuestion(_ question: Question)
}

protocol QueryingViewControllerOutput {
    func viewDidLoad()
}

class QueryingViewController: UITableViewController {

    var presenter: QueryingViewControllerOutput?

    init() {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}

extension QueryingViewController: QueryingViewControllerInput {

    func displayQuestion(_ question: Question) {
        // TODO
    }

}
