//
//  TechnikMenuViewController.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 09.04.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import UIKit

protocol TechnikMenuViewControllerInput {

}

protocol TechnikMenuViewControllerOutput {

}

class TechnikMenuViewController: UIViewController {

    var presenter: TechnikMenuViewControllerOutput!

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Technik"
        tabBarItem = UITabBarItem(title: "Technik", image: UIImage(named: "Technik"), tag: 1)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TechnikMenuViewController: TechnikMenuViewControllerInput {

}
