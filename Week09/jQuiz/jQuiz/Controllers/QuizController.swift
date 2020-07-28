//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var clues: [Clue] = []
    var correctAnswerClue: ClueViewModel?
    var points: Int = 0
    
    let dataSource = CluesDataSource()

    lazy var viewModel : QuizViewModelDelegate = {
        let viewModel = QuizViewModel(dataSource: dataSource)
        return viewModel
    }()
    
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
        self.viewModel.getClues { (success) in
            DispatchQueue.main.async {
                self.hideSpinnerView()
            }            
            if success {
                if let clue = self.viewModel.getCorrectClue() {
                    self.correctAnswerClue = clue
                    DispatchQueue.main.async {
                        self.setUpView()
                    }
                }
            }
            else {
                self.getClues()
            }
        }
        
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AnswerCell.nib, forCellReuseIdentifier: AnswerCell.identifier)
        
        self.dataSource.data.addObserverAndNotify(observer: self) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpView() {
        self.categoryLabel.text = self.correctAnswerClue?.category
        self.clueLabel.text = self.correctAnswerClue?.question
    }

}

extension QuizController {
    
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

extension QuizController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = self.dataSource.data.value[indexPath.row] as? ClueViewModel,
            let selectedAnswerId = item.clue.id,
            let correctAnswer = correctAnswerClue,
            let correctAnswerId = correctAnswer.clue.id,
            selectedAnswerId == correctAnswerId {
            
            //print("Value: \(correctAnswer.point)")
            //print("Total Value (Before): \(self.points)")
            self.points += correctAnswer.point
            //print("Total Value (After): \(self.points)")
            self.scoreLabel.text = "\(self.points)"
            
            getClues()
        }
        else {
            getClues()
        }
    }
    
}

