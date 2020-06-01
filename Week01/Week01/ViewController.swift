//
//  ViewController.swift
//  Week01
//
//  Created by Asif Ahmed Jesi on 30/5/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - ViewController Outlets
    @IBOutlet weak var labelColorName: UILabel!
    @IBOutlet weak var labelRedOrHueTitle: UILabel!
    @IBOutlet weak var labelGreenOrSaturationTitle: UILabel!
    @IBOutlet weak var labelBlueOrBrightnessTitle: UILabel!
    @IBOutlet weak var labelRedOrHueValue: UILabel!
    @IBOutlet weak var labelGreenOrSaturationValue: UILabel!
    @IBOutlet weak var labelBlueOrBrightnessValue: UILabel!
    
    @IBOutlet weak var sliderRedOrHue: UISlider!
    @IBOutlet weak var sliderGreenOrSaturation: UISlider!
    @IBOutlet weak var sliderBlueOrBrightness: UISlider!
    
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var buttonSetColor: UIButton!
    @IBOutlet weak var buttonReset: UIButton!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    let maxRGBValue: Float = 255
    let maxHueValue: Float = 360
    let maxSaturationAndBrightnessValue: Float = 100
    
    var isRGB: Bool {
        get {
            return segmentedControl.selectedSegmentIndex == 0
        }
    }
    
    // MARK: - ViewController Lifecycle Events
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.selectedSegmentIndex = 0
        
        initSliders()
        reset()
    }

}

// MARK: - ViewController Actions
extension ViewController {
    
    // MARK: - Slider Actions
    @IBAction func sliderRedOrHueValueChanged(_ sender: UISlider) {
        labelRedOrHueValue.text = String(Int(sender.value.rounded()))
    }
    
    @IBAction func sliderGreenOrSaturationValueChanged(_ sender: UISlider) {
        labelGreenOrSaturationValue.text = String(Int(sender.value.rounded()))
    }
    
    @IBAction func sliderBlueOrBrightnessValueChanged(_ sender: UISlider) {
        labelBlueOrBrightnessValue.text = String(Int(sender.value.rounded()))
    }
    
    // MARK: - Segmented Control Actions
    @IBAction func segmentedControlModeChanged(_ sender: UISegmentedControl) {
        
        initSliders()
        reset()
    }
    
    // MARK: - Button Actions
    @IBAction func buttonInfoTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func buttonSetColorTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Please enter a name", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.delegate = self
            textField.returnKeyType = .done
        }
        let action = UIAlertAction(title: "OK", style: .default, handler: { action in
            
            let textField = alert.textFields![0]
            if let colorName = textField.text, colorName.trimmingCharacters(in: .whitespacesAndNewlines) != ""  {
                
                self.labelColorName.text = colorName
            }
            else {
                
                if self.labelColorName.text == "Color not set" {
                    self.labelColorName.text = "Please enter a name"
                }
            }
            
            textField.resignFirstResponder()
            self.setColor()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonResetTapped(_ sender: UIButton) {
        
        reset()
    }
    
}

// MARK: - TextField Delegate Methods
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let colorName = textField.text, colorName.trimmingCharacters(in: .whitespacesAndNewlines) != ""  {
            
            self.labelColorName.text = colorName
        }
        else {
            
            if self.labelColorName.text == "Color not set" {
                self.labelColorName.text = "Please enter a name"
            }
        }
        
        self.setColor()
        textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        return true
    }
}

// MARK: - Color Setting Logic
extension ViewController {
    
    func setColor() {
        
        let redOrHue = sliderRedOrHue.value.rounded()
        let greenOrSaturation = sliderGreenOrSaturation.value.rounded()
        let blueOrBrightness = sliderBlueOrBrightness.value.rounded()
        
        let color = isRGB
            ? getColorFromRGB(red: redOrHue, green: greenOrSaturation, blue: blueOrBrightness)
            : getColorFromHSB(hue: redOrHue, saturation: greenOrSaturation, brightness: blueOrBrightness)
        
        view.backgroundColor = color
        
        let labelColor = color.getContrastColor()
        updateLabelColor(color: labelColor)
    }
    
    func initSliders() {
        
        if isRGB {
            
            labelRedOrHueTitle.text = "Red"
            labelGreenOrSaturationTitle.text = "Green"
            labelBlueOrBrightnessTitle.text = "Blue"
            
            sliderRedOrHue.minimumValue = 0
            sliderRedOrHue.maximumValue = maxRGBValue
            
            sliderGreenOrSaturation.minimumValue = 0
            sliderGreenOrSaturation.maximumValue = maxRGBValue
            
            sliderBlueOrBrightness.minimumValue = 0
            sliderBlueOrBrightness.maximumValue = maxRGBValue
        }
        else {
            
            labelRedOrHueTitle.text = "Hue"
            labelGreenOrSaturationTitle.text = "Saturation"
            labelBlueOrBrightnessTitle.text = "Brightness"
            
            sliderRedOrHue.minimumValue = 0
            sliderRedOrHue.maximumValue = maxHueValue
            
            sliderGreenOrSaturation.minimumValue = 0
            sliderGreenOrSaturation.maximumValue = maxSaturationAndBrightnessValue
            
            sliderBlueOrBrightness.minimumValue = 0
            sliderBlueOrBrightness.maximumValue = maxSaturationAndBrightnessValue
        }
    }
    
    func reset() {

        sliderBlueOrBrightness.value = 0
        sliderGreenOrSaturation.value = 0
        sliderRedOrHue.value = 0

        labelRedOrHueValue.text = String(0)
        labelGreenOrSaturationValue.text = String(0)
        labelBlueOrBrightnessValue.text = String(0)

        labelColorName.text = "Color not set"
        
        view.backgroundColor = UIColor.white
        
        updateLabelColor(color: .black)
    }
    
    func updateLabelColor(color: UIColor) {
        
        labelRedOrHueTitle.textColor = color
        labelRedOrHueValue.textColor = color
        labelGreenOrSaturationTitle.textColor = color
        labelGreenOrSaturationValue.textColor = color
        labelBlueOrBrightnessTitle.textColor = color
        labelBlueOrBrightnessValue.textColor = color
        labelColorName.textColor = color
    }

    func getColorFromRGB(red: Float, green: Float, blue: Float) -> UIColor {
        
        let modifiedRed = CGFloat(red/maxRGBValue)
        let modifiedGreen = CGFloat(green/maxRGBValue)
        let modifiedBlue = CGFloat(blue/maxRGBValue)
        
        return UIColor(red: modifiedRed, green: modifiedGreen, blue: modifiedBlue, alpha: 1.0)
    }
    
    func getColorFromHSB(hue: Float, saturation: Float, brightness: Float) -> UIColor {
        
        let modifiedHue = CGFloat(hue/maxHueValue)
        let modifiedSaturation = CGFloat(saturation/maxSaturationAndBrightnessValue)
        let modifiedBrightness = CGFloat(brightness/maxSaturationAndBrightnessValue)
        
        return UIColor(hue: modifiedHue, saturation: modifiedSaturation, brightness: modifiedBrightness, alpha: 1.0)
    }
    
}
