//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var selectedImage: UIImage?
        
        let dataSource = MediaPostsDataSource()

        lazy var viewModel : MediaPostsViewModelDelegate = {
            let viewModel = MediaPostsViewModel(dataSource: dataSource)
            return viewModel
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            setUpTableView()
            
            self.dataSource.data.addObserverAndNotify(observer: self) { [weak self] in
                self?.tableview.reloadData()
            }
            self.viewModel.fetchData()
        }

    }

    extension ViewController {
        
        @IBAction func didPressCreateTextPostButton(_ sender: Any) {
            self.selectedImage = nil
            showAddPostAlert()
        }
        @IBAction func didPressCreateImagePostButton(_ sender: Any) {
            showImageGalleryAlert()
        }
        
    }

    extension ViewController {

        func setUpTableView() {
            tableview.dataSource = dataSource
            tableview.delegate = self
            tableview.backgroundColor = .clear
            tableview.separatorStyle = .none
            
            tableview.register(ImagePostCell.nib, forCellReuseIdentifier: ImagePostCell.identifier)
            tableview.register(TextPostCell.nib, forCellReuseIdentifier: TextPostCell.identifier)
        }

        func showAddPostAlert() {
            let title = "Create Post"
            let message = "What's up? :]"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alert.addTextField { (textField) in
                textField.delegate = self
                textField.placeholder = "Username"
                textField.returnKeyType = .next
            }
            alert.addTextField { (textField) in
                textField.delegate = self
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

    extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage], let image = originalImage as? UIImage {
                selectedImage = image
            }
            dismiss(animated: true, completion: nil)
            
            if selectedImage != nil {
                showAddPostAlert()
            }
        }
    }

    extension ViewController: UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return self.dataSource.data.value[indexPath.row].rowHeight
        }
    }

    // MARK: - TextField Delegate Methods
    extension ViewController : UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            if let colorName = textField.text, colorName.trimmingCharacters(in: .whitespacesAndNewlines) != ""  {
                
                
            }
            else {
                
                
            }
            
            textField.resignFirstResponder()
            dismiss(animated: true, completion: nil)
            return true
        }
    }

