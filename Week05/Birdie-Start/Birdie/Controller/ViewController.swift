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
    
    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        self.selectedImage = nil
        showAddPostAlert()
    }
    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        showImageGalleryAlert()
    }
    
    func setUpTableView() {
        tableview.dataSource = dataSource
        tableview.delegate = self
        tableview.backgroundColor = .clear
        tableview.separatorStyle = .none
        
        tableview.register(ImagePostCell.nib, forCellReuseIdentifier: ImagePostCell.identifier)
        tableview.register(TextPostCell.nib, forCellReuseIdentifier: TextPostCell.identifier)
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.dataSource.data.value[indexPath.row].rowHeight
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
