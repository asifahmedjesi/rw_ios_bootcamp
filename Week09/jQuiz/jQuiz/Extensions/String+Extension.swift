//
//  String+Extension.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 28/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension String {
    
    func htmlAttributedString() -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                font-family: -apple-system;
                font-size: 20px;
                text-align: center;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf8) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}
