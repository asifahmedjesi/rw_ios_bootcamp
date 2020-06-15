
import Foundation
import UIKit

extension UILabel {
  
  func applyTheme() {
    
    guard let currentTheme = ThemeManager.shared.currentTheme else { return }
    textColor = currentTheme.textColor
  }
}
