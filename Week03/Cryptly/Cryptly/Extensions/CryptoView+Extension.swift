
import Foundation
import UIKit

extension CryptoView {

  func applyTheme() {
    
    guard let currentTheme = ThemeManager.shared.currentTheme else { return }
    backgroundColor = currentTheme.widgetBackgroundColor
    layer.borderColor = currentTheme.borderColor.cgColor
  }
}
