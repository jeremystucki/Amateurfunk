//
//  AmateurfunkUITests.swift
//  AmateurfunkUITests
//
//  Created by Jeremy Stucki on 27.05.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import XCTest

class AmateurfunkUITests: XCTestCase {

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }

}
