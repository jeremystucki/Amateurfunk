//
//  QueryingViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 04.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol QueryingViewControllerInput {

}

protocol QueryingViewControllerOutput {
    func viewDidLoad()
}

class QueryingViewController: UITableViewController {

    var presenter: QueryingViewControllerOutput?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }

}

extension QueryingViewController: QueryingViewControllerInput {

}
