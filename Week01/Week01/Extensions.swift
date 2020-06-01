//
//  Extensions.swift
//  Week01
//
//  Created by Asif Ahmed Jesi on 1/6/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

extension UIColor {

    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
    
    func getContrastColor() -> UIColor {
        
        let luma = ((0.299 * self.rgba.red) + (0.587 * self.rgba.green) + (0.114 * self.rgba.blue))
        return luma > 0.5 ? UIColor.black : UIColor.white
    }
}
