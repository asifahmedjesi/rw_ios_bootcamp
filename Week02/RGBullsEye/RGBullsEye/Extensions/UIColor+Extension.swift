//
//  UIColor+Extension.swift
//  RGBullsEye
//
//  Created by Asif Ahmed Jesi on 9/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    convenience init(rgbStruct rgb: RGB) {
        let r = CGFloat(rgb.r) / 255.0
        let g = CGFloat(rgb.g) / 255.0
        let b = CGFloat(rgb.b) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
