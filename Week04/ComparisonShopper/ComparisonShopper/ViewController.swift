//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!

    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!

    var house1: House?
    var house2: House?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.house1 = getNewHouse(address: "New York", price: "$12,000", bedrooms: "3 bedrooms")
        
        setUpLeftSideUI()
        setUpRightSideUI()
    }

    func setUpLeftSideUI() {
        titleLabelLeft.text = house1!.address!
        priceLabelLeft.text = house1!.price!
        roomLabelLeft.text = house1!.bedrooms!
    }

    func setUpRightSideUI() {
        
        if house2 == nil {
            
            titleLabelRight.alpha = 0
            imageViewRight.alpha = 0
            priceLabelRight.alpha = 0
            roomLabelRight.alpha = 0
        } else {
            
            titleLabelRight.alpha = 1
            imageViewRight.alpha = 1
            priceLabelRight.alpha = 1
            roomLabelRight.alpha = 1
            
            titleLabelRight.text! = house2!.address!
            priceLabelRight.text! = house2!.price!
            roomLabelRight.text! = house2!.bedrooms!
        }
    }

    @IBAction func didPressAddRightHouseButton(_ sender: Any) {
        openAlertView()
    }

    func openAlertView() {
        let alert = UIAlertController(title: "Alert Title", message: "Alert Message", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "address"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "price"
        }

        alert.addTextField { (textField) in
            textField.placeholder = "bedrooms"
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
            
            let address = alert.textFields?[0].text ?? ""
            let price = alert.textFields?[1].text ?? ""
            let bedrooms = alert.textFields?[2].text ?? ""
            
            self.house2 = self.getNewHouse(address: address, price: price, bedrooms: bedrooms)
            self.setUpRightSideUI()
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func getNewHouse(address: String, price: String, bedrooms: String) -> House {
        var house = House()
        house.address = address
        house.price = price
        house.bedrooms = bedrooms
        return house
    }

}

struct House {
    var address: String?
    var price: String?
    var bedrooms: String?
}

