
import UIKit

class HomeViewController: UIViewController{

  @IBOutlet weak var view1: CryptoView!
  @IBOutlet weak var view2: CryptoView!
  @IBOutlet weak var view3: CryptoView!
  @IBOutlet weak var view4: CryptoView!
  @IBOutlet weak var view5: CryptoView!
  @IBOutlet weak var headingLabel: HeadingLabel!
  @IBOutlet weak var view1TextLabel: WidgetLabel!
  @IBOutlet weak var view2TextLabel: WidgetLabel!
  @IBOutlet weak var view3TextLabel: WidgetLabel!
  @IBOutlet weak var view4TextLabel: WidgetLabel!
  @IBOutlet weak var view5TextLabel: WidgetLabel!
  @IBOutlet weak var view6TextLabel: WidgetLabel!
  @IBOutlet weak var view7TextLabel: WidgetLabel!
  @IBOutlet weak var themeSwitch: UISwitch!

  override func viewDidLoad() {
    super.viewDidLoad()
    setViewData()
    setTheme()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.registerForTheme()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.unregisterForTheme()
  }

  func setViewData() {
    self.view1TextLabel.text = CryptoCurrencyManager.shared.getOwnedCryptoCurrencyNames().joined(separator: ", ")
    self.view2TextLabel.text = CryptoCurrencyManager.shared.getRisingCryptoCurrencyNames().joined(separator: ", ")
    self.view3TextLabel.text = CryptoCurrencyManager.shared.getFallingCryptoCurrencyNames().joined(separator: ", ")
    self.view5TextLabel.text = CryptoCurrencyManager.shared.getMostFallingValue().description
    self.view7TextLabel.text = CryptoCurrencyManager.shared.getMostRisingValue().description
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    self.setTheme()
  }
  
  func setTheme() {
    if self.themeSwitch.isOn { ThemeManager.shared.set(theme: DarkTheme()) }
    else { ThemeManager.shared.set(theme: LightTheme()) }
  }
  
  func applyTheme() {
    guard let currentTheme = ThemeManager.shared.currentTheme else { return }
    
    for subview in self.view.subviews {
      if subview is CryptoView, let cryptoView = subview as? CryptoView {
        
        cryptoView.applyTheme()
        for innerSubview in subview.subviews {
          if innerSubview is UILabel, let label = innerSubview as? UILabel { label.applyTheme() }
        }
        
      }
    }
    
    self.headingLabel.applyTheme()
    self.view.backgroundColor = currentTheme.backgroundColor
  }
  
  
}

extension HomeViewController: Themeable {

  func registerForTheme() {
    let name = Notification.Name.init("themeChanged")
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: name, object: nil)
  }

  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

  @objc func themeChanged() {
    self.applyTheme()
  }

}
