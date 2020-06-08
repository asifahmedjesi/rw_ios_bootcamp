//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Asif Ahmed Jesi on 8/6/20.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGameResult {
    var points: Int = 0
    var feedback: String = ""
}

class BullsEyeGame {
    
    var currentValue = 0
    
    private(set) var targetValue = 0
    private(set) var score = 0
    private(set) var round = 0
    
    private var max = 100
    private var min = 1
    private var difference = 0
    private var points = 0
    
    func start() {
        self.score = 0
        self.round = 0
        self.startRound()
    }
    func startRound() {
        self.round += 1
        self.targetValue = Int.random(in: min...max)
        self.currentValue = (min + max)/2
    }
    func getResult() -> BullsEyeGameResult {
        self.calculatePoints()
        
        var feedback: String = ""
        if difference == 0 {
          feedback = "Perfect!"
        }
        else if difference < 5 {
          feedback = "You almost had it!"
        }
        else if difference < 10 {
          feedback = "Pretty good!"
        }
        else {
          feedback = "Not even close..."
        }
        
        return BullsEyeGameResult(points: self.points, feedback: feedback)
    }
    
    private func getDifference(first: Int, second: Int) -> Int {
        return abs(first - second)
    }
    private func calculatePoints() {
        self.difference = self.getDifference(first: self.targetValue, second: self.currentValue)
        self.points = max - difference
        self.calculateBonusPoints()
        self.score += points        
    }
    private func calculateBonusPoints() {
        if difference == 0 {
            self.points += 100
        }
        else if difference < 5 {
            if difference == 1 {
                self.points += 50
            }
        }
    }
    
}
