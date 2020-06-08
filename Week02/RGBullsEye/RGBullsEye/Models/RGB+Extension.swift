//
//  RGB+Extension.swift
//  RGBullsEye
//
//  Created by Asif Ahmed Jesi on 9/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

extension RGB {

    static func random() -> RGB {
        let r = Int.random(in: 0...255)
        let g = Int.random(in: 0...255)
        let b = Int.random(in: 0...255)
        return RGB(r: r, g: g, b: b)
    }
}
