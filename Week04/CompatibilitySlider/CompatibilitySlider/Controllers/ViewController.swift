//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonNextItemCalculate: UIButton!
    @IBOutlet weak var person1RatingLabel: UILabel!
    @IBOutlet weak var person2RatingLabel: UILabel!
    @IBOutlet weak var terribleImage: UIImageView!
    @IBOutlet weak var badImage: UIImageView!
    @IBOutlet weak var mehImage: UIImageView!
    @IBOutlet weak var goodImage: UIImageView!
    @IBOutlet weak var greatImage: UIImageView!
    
    var compatibilityItems = ["Cats", "Dogs" , "Tigers"]
    var ratings = ["Terrible": 1, "Bad": 2, "Meh": 3, "Good": 4, "Great": 5 ]
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPerson = person1
        
        resetSlider()
        setCompatibilityItemTitle()
        updateTitle()
        clearRatingLabels()
        
        setupTapGesturesRatings()
    }
    
    func setupTapGesturesRatings() {
        
        let terribleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        terribleImage.isUserInteractionEnabled = true
        terribleImage.tag = 1
        terribleImage.addGestureRecognizer(terribleTap)
        
        let badTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        badImage.isUserInteractionEnabled = true
        badImage.tag = 2
        badImage.addGestureRecognizer(badTap)
        
        let mehTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        mehImage.isUserInteractionEnabled = true
        mehImage.tag = 3
        mehImage.addGestureRecognizer(mehTap)
        
        let goodTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        goodImage.isUserInteractionEnabled = true
        goodImage.tag = 4
        goodImage.addGestureRecognizer(goodTap)
        
        let greatTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(gesture:)))
        greatImage.isUserInteractionEnabled = true
        greatImage.tag = 5
        greatImage.addGestureRecognizer(greatTap)
    }
    
    @objc func handleTapGesture(gesture : UITapGestureRecognizer)
    {
        guard let v = gesture.view else { return }
        let tag = v.tag
        
        slider.value = Float(tag)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        switch sender.value {
        case 1.0..<1.5:
            sender.value = 1.0
        case 1.5..<2.5:
            sender.value = 2.0
        case 2.5..<3.5:
            sender.value = 3.0
        case 3.5..<4.5:
            sender.value = 4.0
        case 4.5...5.0:
            sender.value = 5.0
        default:
            resetSlider()
        }
    }

    @IBAction func didPressNextItemButton(_ sender: Any) {
        
        guard let current = currentPerson else { return }
        if currentItemIndex >= compatibilityItems.count { return }
        
        current.items.updateValue(slider.value, forKey: compatibilityItems[currentItemIndex])
        print("\(compatibilityItems[currentItemIndex]): \(Int(slider.value))")
        
        if current.id == person1.id {
            updateRatingLabel(label: person1RatingLabel, title: "Person 1 Ratings:")
        }
        if current.id == person2.id {
            updateRatingLabel(label: person2RatingLabel, title: "Person 2 Ratings:")
        }
        
        if currentItemIndex == compatibilityItems.count - 1 && current.id == person1.id {
            currentPerson = person2
        }
        else if currentItemIndex == compatibilityItems.count - 1 && current.id == person2.id {
            showResults(score: calculateCompatibility()) { aciton in
                self.clearRatingLabels()
            }
            currentPerson = person1
            clearAllScores()
        }
        
        currentItemIndex += 1
        currentItemIndex = currentItemIndex % compatibilityItems.count
        
        resetSlider()
        setCompatibilityItemTitle()
        updateTitle()
    }
    
    func clearRatingLabels() {
        person1RatingLabel.text = "Person 1 Ratings:"
        person2RatingLabel.text = "Person 2 Ratings:"
    }
    
    func updateRatingLabel(label: UILabel, title: String) {
        
        guard let current = currentPerson else { return }
        
        var fullstring: String = title + "\n"
        for item in current.items {
            if let rating = ratings.first(where: { (key, value) -> Bool in value == Int(item.value) }) {
                fullstring.append(contentsOf: "\(item.key): \(rating.key)\n")
            }
        }
        label.text = fullstring
    }
    
    func setCompatibilityItemTitle() {
        if currentItemIndex >= compatibilityItems.count { return }
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
    }
    
    func updateTitle() {
        
        guard let current = currentPerson else { return }
        
        if current.id == person1.id {
            questionLabel.text = "Person 1, what do you think about..."
        }
        if current.id == person2.id {
            questionLabel.text = "Person 2, how do you feel about..."
        }
    }
    
    func resetSlider() {
        slider.value = 3
    }
    
    func clearAllScores() {
        person1.items.removeAll()
        person2.items.removeAll()
    }
    
    func showResults(score: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Results", message: "You two are \(score) compatible.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true)
    }

    func calculateCompatibility() -> String {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating)/5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages/Double(compatibilityItems.count)
        print(matchPercentage, "%")
        
        let matchString = 100 - (matchPercentage * 100).rounded()
        return "\(matchString)%"
    }

}

