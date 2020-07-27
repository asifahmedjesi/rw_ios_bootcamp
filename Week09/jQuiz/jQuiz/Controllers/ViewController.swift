//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let albumImageUrl = URL(string: AppConstants.LOGO_IMAGE) {
            logoImageView.load(url: albumImageUrl)
        }            
        
        self.categoryLabel.text = nil
        self.clueLabel.text = nil
        self.scoreLabel.text = "\(self.points)"
        
        setUpTableView()
        
        manageSound()
        getClues()
    }
    
    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        manageSound()
    }
    
    func getClues() {
        
        self.showSpinnerView()
        
        Networking.shared.getRandomCategory(completion: { (categoryId) in
            guard let id = categoryId else { return }
            
            Networking.shared.getAllCluesInCategory(categoryId: id) { (questions) in
                
                DispatchQueue.main.async {
                    self.hideSpinnerView()
                }                
                
                if questions.count == 0 {
                    self.getClues()
                    return
                }
                
                let correctAnswerIndex = Int.random(in: 0...3)
                self.correctAnswerClue = questions[correctAnswerIndex]
                self.clues = questions
                
                DispatchQueue.main.async {
                    self.setUpView()
                    print("Correct Answer Index: \(correctAnswerIndex)")
                }
            }

        })
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AnswerCell.nib, forCellReuseIdentifier: AnswerCell.identifier)
    }
    
    func setUpView() {
        self.categoryLabel.text = self.correctAnswerClue?.category?.title ?? ""
        self.clueLabel.text = self.correctAnswerClue?.question ?? ""
        self.tableView.reloadData()
    }
    
    func manageSound() {
        updatePlayerView()
        if let enabled = SoundManager.shared.isSoundEnabled {
            if enabled {
                SoundManager.shared.playSound()
            }
            else {
                SoundManager.shared.stopSound()
            }
        }
        else {
            SoundManager.shared.playSound()
        }
    }
    
    func updatePlayerView() {
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as! AnswerCell
        cell.selectionStyle = .none
        cell.answerLabel.text = clues[indexPath.row].answer ?? ""
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = clues[indexPath.row]
        if let selectedAnswerId = item.id, let correctAnswer = correctAnswerClue, let correctAnswerId = correctAnswer.id,
            selectedAnswerId == correctAnswerId {
            
            print("Value: \(correctAnswer.value ?? 0)")
            print("Total Value (Before): \(self.points)")
            self.points += correctAnswer.value ?? 0
            print("Total Value (After): \(self.points)")
            self.scoreLabel.text = "\(self.points)"
            getClues()
        }
        else {
            getClues()
        }
    }
}

