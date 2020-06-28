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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        MediaPostsHandler.shared.getPosts()
        tableview.reloadData()
    }

}

extension ViewController {
    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        showAlert()
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        showImageAlert()
    }
    
}

extension ViewController {
    
    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        
        tableview.register(ImagePostCell.nib, forCellReuseIdentifier: ImagePostCell.identifier)
        tableview.register(TextPostCell.nib, forCellReuseIdentifier: TextPostCell.identifier)
    }

    func showAlert() {

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
            if let username = usernameTextField.text,
                let textbody = textbodyTextField.text,
                username.trimmingCharacters(in: .whitespacesAndNewlines) != "",
                textbody.trimmingCharacters(in: .whitespacesAndNewlines) != ""  {
                
                if self.selectedImage == nil {
                    let post = TextPost(textBody: textbody, userName: username, timestamp: Date())
                    MediaPostsHandler.shared.addTextPost(textPost: post)
                }
                else {
                    let post = ImagePost(textBody: textbody, userName: username, timestamp: Date(), image: self.selectedImage!)
                    MediaPostsHandler.shared.addImagePost(imagePost: post)
                }
                
                self.tableview.reloadData()
            }
            else {

            }

            usernameTextField.resignFirstResponder()
            textbodyTextField.resignFirstResponder()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showImageAlert() {
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
            showAlert()
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        
        if let data = cellData as? TextPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextPostCell.identifier, for: indexPath) as! TextPostCell
            
            cell.titleLabel.text = data.userName
            cell.bodytextLabel.text = data.textBody ?? ""
            cell.postedOnLabel.text = "25 June, 2020 12:30 PM"
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        if let data = cellData as? ImagePost {
            let cell = tableView.dequeueReusableCell(withIdentifier: ImagePostCell.identifier, for: indexPath) as! ImagePostCell
            
            cell.titleLabel.text = data.userName
            cell.bodytextLabel.text = data.textBody ?? ""
            cell.postedOnLabel.text = "25 June, 2020 12:30 PM"
            cell.bodyImage.image = data.image
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 0.000001))
        view.backgroundColor = .clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: 0.000001))
        view.backgroundColor = .clear
        return view
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

