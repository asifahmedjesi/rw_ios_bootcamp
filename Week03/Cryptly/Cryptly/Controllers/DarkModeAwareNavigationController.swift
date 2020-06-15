
import Foundation
import UIKit

class DarkModeAwareNavigationController: UINavigationController {

  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
    self.updateBarTintColor()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.updateBarTintColor()
  }

  private func updateBarTintColor() {
    if let currentTheme = ThemeManager.shared.currentTheme {
      self.navigationBar.barTintColor = currentTheme.widgetBackgroundColor
    }
    else {
      self.navigationBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.registerForTheme()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.unregisterForTheme()
  }

}

extension DarkModeAwareNavigationController: Themeable {
  
  func registerForTheme() {
    let name = Notification.Name.init("themeChanged")
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: name, object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    self.updateBarTintColor()
  }
}
