//
//  UIViewcontroller+Extension.swift
//  BullsEye
//
//  Created by Asif Ahmed Jesi on 8/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
}
