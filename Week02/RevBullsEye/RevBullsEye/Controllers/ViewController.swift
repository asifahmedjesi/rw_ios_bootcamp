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
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var hitMeButton: UIButton!

    static let minValue = 1
    static let maxValue = 100
    static let maxDigit = String(maxValue).count

    var game = BullsEyeGame()

    override func viewDidLoad() {
        super.viewDidLoad()

        guessText.delegate = self
        guessText.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)

        self.game.start()
        self.updateView()
        self.enableHitMeButton(enable: false)
    }

    @IBAction func showAlert() {

        let result = self.game.getResult()
        let title = result.feedback
        let message = "You scored \(result.points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.game.startRound()
            self.updateView()
            self.enableHitMeButton(enable: false)
        })
        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        slider.value = Float(self.game.targetValue)
    }

    func updateView() {
        guessText.text = ""

        scoreLabel.text = String(self.game.score)
        roundLabel.text = String(self.game.round)
        slider.value = Float(self.game.targetValue)

        print("Target Value: \(self.game.targetValue)")
    }

    @IBAction func startNewGame() {
        self.game.start()
        self.updateView()
        self.enableHitMeButton(enable: false)
    }

    @objc private func editingChanged(_ textField: UITextField) {
        if let num = Int(textField.text!), (1...100).contains(num) {
            textField.text = "\(num)"
            self.game.currentValue = num
            self.enableHitMeButton(enable: true)
        } else {
            textField.text = ""
            self.enableHitMeButton(enable: false)
        }
    }

    func enableHitMeButton(enable: Bool) {
        self.hitMeButton.isEnabled = enable
        self.hitMeButton.alpha = enable ? 1.0 : 0.6
    }

}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text!.count >= ViewController.maxDigit && !string.isEmpty {
            return false
        }
        
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
}



