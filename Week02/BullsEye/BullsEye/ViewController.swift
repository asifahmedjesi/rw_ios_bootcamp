//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var game = BullsEyeGame()

    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
        game.start()
        updateView()
    }

    @IBAction func showAlert() {
        
        let result = game.getResult()
        let title = result.feedback
        let message = "You scored \(result.points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.game.startRound()
            self.updateView()
        })
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        game.currentValue = Int(roundedValue)
    }
    
    func updateView() {
        targetLabel.text = String(game.targetValue)
        scoreLabel.text = String(game.score)
        roundLabel.text = String(game.round)
        slider.value = Float(game.currentValue)
    }

    @IBAction func startNewGame() {
        game.start()
        self.updateView()
    }
  
}



