//
//  ViewController+Extension.swift
//  Birdie
//
//  Created by Asif Ahmed Jesi on 30/6/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {

    func showAddPostAlert() {
        let title = "Create Post"
        let message = "What's up? :]"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.returnKeyType = .next
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Text"
            textField.returnKeyType = .done
        }

        let action = UIAlertAction(title: "OK", style: .default, handler: { action in

            let usernameTextField = alert.textFields![0]
            let textbodyTextField = alert.textFields![1]
            
            if let username = usernameTextField.text, let textbody = textbodyTextField.text,
                username.trimmingCharacters(in: .whitespacesAndNewlines) != "", textbody.trimmingCharacters(in: .whitespacesAndNewlines) != ""  {
                
                if self.selectedImage == nil {
                    self.viewModel.addPost(username: username, textbody: textbody)
                }
                else {
                    self.viewModel.addPost(username: username, textbody: textbody, image: self.selectedImage!)
                    self.selectedImage = nil
                }
                
                self.viewModel.fetchData()
            }

            usernameTextField.resignFirstResponder()
            textbodyTextField.resignFirstResponder()
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    func showImageGalleryAlert() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }

}
