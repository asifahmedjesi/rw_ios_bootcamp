
import Foundation

class BullsEyeGame {

    var currentValue = RGB()

    private(set) var targetValue = RGB()
    private(set) var score = 0
    private(set) var round = 0

    private var difference: Int {
        get {
            return Int((targetValue.difference(target: currentValue) * 100).rounded())
        }
    }    
    private var points = 0
    
    var quickDiff: (rDiff: Int, gDiff: Int, bDiff: Int) {
        get {
            let r = abs(targetValue.r - currentValue.r)
            let g = abs(targetValue.g - currentValue.g)
            let b = abs(targetValue.b - currentValue.b)
            return (rDiff: r, gDiff: g, bDiff: b)
        }
    }
    
    func start() {
        self.score = 0
        self.round = 0
        self.startRound()
    }
    func startRound() {
        self.round += 1
        self.targetValue = RGB.random()
        self.currentValue = RGB()
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
    
    private func calculatePoints() {
        self.points = 100 - difference
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
