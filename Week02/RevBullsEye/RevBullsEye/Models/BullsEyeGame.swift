//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Asif Ahmed Jesi on 8/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

class BullsEyeGame {
    
    var currentValue = 0
    
    private(set) var targetValue = 0
    private(set) var score = 0
    private(set) var round = 0
    
    private var points = 0
    private var quickDiff: Int {
        get {
            return abs(self.targetValue - self.currentValue)
        }
    }
    
    func start() {
        self.score = 0
        self.round = 0
        self.startRound()
    }
    func startRound() {
        self.round += 1
        self.targetValue = Int.random(in: 1...100)
        self.currentValue = 100/2
    }
    func getResult() -> BullsEyeGameResult {
        self.calculatePoints()
        
        var feedback: String = ""
        if quickDiff == 0 {
          feedback = "Perfect!"
        }
        else if quickDiff < 5 {
          feedback = "You almost had it!"
        }
        else if quickDiff < 10 {
          feedback = "Pretty good!"
        }
        else {
          feedback = "Not even close..."
        }
        
        return BullsEyeGameResult(points: self.points, feedback: feedback)
    }
    
    private func calculatePoints() {
        self.points = 100 - self.quickDiff
        self.calculateBonusPoints()
        self.score += points        
    }
    private func calculateBonusPoints() {
        if quickDiff == 0 {
            self.points += 100
        }
        else if quickDiff < 5 {
            if quickDiff == 1 {
                self.points += 50
            }
        }
    }
    
}
