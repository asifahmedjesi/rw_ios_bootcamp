
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var targetTextLabel: UILabel!
    
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    let game = BullsEyeGame()

    @IBAction func aSliderMoved(sender: UISlider) {
        let r = Int(redSlider.value.rounded())
        let g = Int(greenSlider.value.rounded())
        let b = Int(blueSlider.value.rounded())
        
        redLabel.text = r.description
        greenLabel.text = g.description
        blueLabel.text = b.description
        
        self.game.currentValue = RGB(r: r, g: g, b: b)
        guessLabel.backgroundColor = UIColor(rgbStruct: self.game.currentValue)
        
        if sender == redSlider {
            redSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.rDiff)/100.0)
        }
        if sender == greenSlider {
            greenSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.gDiff)/100.0)
        }
        if sender == blueSlider {
            blueSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.bDiff)/100.0)
        }
        
    }

    @IBAction func showAlert(sender: AnyObject) {
        let result = self.game.getResult()
        let title = result.feedback
        let message = "You scored \(result.points) points"
        
        self.showAlert(title: title, message: message) { action in
            self.game.startRound()
            self.updateView()
        }
    }

    @IBAction func startOver(sender: AnyObject) {
        self.game.start()
        self.updateView()
    }

    func updateView() {
        targetLabel.backgroundColor = UIColor(rgbStruct: self.game.targetValue)
        guessLabel.backgroundColor = UIColor(rgbStruct: self.game.currentValue)

        redLabel.text = self.game.currentValue.r.description
        greenLabel.text = self.game.currentValue.g.description
        blueLabel.text = self.game.currentValue.b.description

        scoreLabel.text = String(self.game.score)
        roundLabel.text = String(self.game.round)

        redSlider.value = Float(self.game.currentValue.r)
        greenSlider.value = Float(self.game.currentValue.g)
        blueSlider.value = Float(self.game.currentValue.b)
        
        redSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.rDiff)/100.0)
        greenSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.gDiff)/100.0)
        blueSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(game.quickDiff.bDiff)/100.0)
        
        print("Target Value: R: \(self.game.targetValue.r);  G: \(self.game.targetValue.g);  B: \(self.game.targetValue.b)")
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.game.start()
        self.updateView()
    }
}


