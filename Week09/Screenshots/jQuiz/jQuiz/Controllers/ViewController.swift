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
        
        setUpTableView()
        
        scoreLabel.text = "\(self.points)"

        playSound()
        getClues()
    }

    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        updatePlayerView()
    }
    
    func getClues() {
        
        Networking.shared.getRandomCategory(completion: { (categoryId) in
            guard let id = categoryId else { return }
            
            Networking.shared.getAllCluesInCategory(categoryId: id) { (clues) in
                
                DispatchQueue.main.async {
                    if let item = clues.first {
                        self.correctAnswerClue = item
                        self.points = item.value ?? 0
                    }
                    self.clues = clues
                    self.setUpView()
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
        self.scoreLabel.text = "\(self.points)"
        
        self.tableView.reloadData()
    }
    
    func playSound() {
        updatePlayerView()
        SoundManager.shared.playSound()
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

    }
}

