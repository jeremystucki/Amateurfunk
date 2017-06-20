//
//  Random.swift
//  Amateurfunk
//
//  Created by Jeremy Stucki on 20.06.17.
//  Copyright © 2017 Jeremy Stucki. All rights reserved.
//

import Foundation

extension Array {

    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }

}
