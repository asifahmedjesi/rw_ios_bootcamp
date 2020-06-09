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

        self.game.start()
        self.updateView()
    }

    @IBAction func showAlert() {
        let result = self.game.getResult()
        let title = result.feedback
        let message = "You scored \(result.points) points"
        
        self.showAlert(title: title, message: message) { action in
            self.game.startRound()
            self.updateView()
        }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        self.game.currentValue = Int(slider.value.rounded())
        self.slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.difference)/100.0)
    }

    func updateView() {
        targetLabel.text = String(self.game.targetValue)
        scoreLabel.text = String(self.game.score)
        roundLabel.text = String(self.game.round)
        slider.value = Float(self.game.currentValue)
        
        self.slider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(1)
        
        print("Target Value: \(self.game.targetValue)")
    }

    @IBAction func startNewGame() {
        self.game.start()
        self.updateView()
    }

}



