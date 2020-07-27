//
//  UIImageView+Extension.swift
//  jQuiz
//
//  Created by Asif Ahmed Jesi on 28/7/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIImageView {
    
    public static var imageStore: [String: UIImage] = [:]
    
    func load(url: URL) {
        
        print("Path: \(url.path)")
        
        let key = url.path
        if let cachedImage = UIImageView.imageStore[key] {
            DispatchQueue.main.async {
                self.image = cachedImage
                return
            }
        }
        
        let task = URLSession.shared.downloadTask(with: url) { location, response, error in
            guard let location = location, let imageData = try? Data(contentsOf: location), let image = UIImage(data: imageData)
                else { return }
            DispatchQueue.main.async {
                UIImageView.imageStore[key] = image
                self.image = image
            }
        }
        task.resume()
    }
    
}
