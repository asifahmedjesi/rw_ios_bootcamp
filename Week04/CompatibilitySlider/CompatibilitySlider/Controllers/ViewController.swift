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
    
    var compatibilityItems = ["Cats", "Dogs" , "Tigers"] // Add more!
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
        
        if currentItemIndex == compatibilityItems.count - 1 && current.id == person1.id {
            currentPerson = person2
        }
        else if currentItemIndex == compatibilityItems.count - 1 && current.id == person2.id {
            showResults(score: calculateCompatibility())
            currentPerson = person1
            clearAllScores()
        }
        
        currentItemIndex += 1
        currentItemIndex = currentItemIndex % compatibilityItems.count
        
        resetSlider()
        setCompatibilityItemTitle()
        updateTitle()
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
    
    func showResults(score: String) {
        let alert = UIAlertController(title: "Results", message: "You two are \(score) compatible.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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

