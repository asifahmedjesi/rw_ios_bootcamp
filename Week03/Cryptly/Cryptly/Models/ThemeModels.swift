
import Foundation
import UIKit

protocol Themeable {
  func registerForTheme()
  func unregisterForTheme()
  func themeChanged()
}

protocol Theme {

  var backgroundColor: UIColor { get }
  var textColor: UIColor { get }
  var borderColor: UIColor { get }
  var widgetBackgroundColor: UIColor { get }
}

class LightTheme: Theme {
  
  var backgroundColor: UIColor { get { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) } }
  var textColor: UIColor { get { return #colorLiteral(red: 0.07843137255, green: 0.07843137255, blue: 0.08235294118, alpha: 1) } }
  var borderColor: UIColor { get { return #colorLiteral(red: 0.7450980392, green: 0.7490196078, blue: 0.7450980392, alpha: 1) } }
  var widgetBackgroundColor: UIColor { get { return #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1) } }
}

class DarkTheme: Theme {
  
  var backgroundColor: UIColor { get { return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) } }
  var textColor: UIColor { get { return #colorLiteral(red: 0.831372549, green: 0.5607843137, blue: 0.2078431373, alpha: 1) } }
  var borderColor: UIColor { get { return #colorLiteral(red: 0.4039215686, green: 0.6823529412, blue: 0.7843137255, alpha: 1) } }
  var widgetBackgroundColor: UIColor { get { return #colorLiteral(red: 0.1725490196, green: 0.1764705882, blue: 0.1843137255, alpha: 1) } }
}
