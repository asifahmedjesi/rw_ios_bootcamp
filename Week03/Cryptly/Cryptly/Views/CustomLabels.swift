
import Foundation
import UIKit

class HeadingLabel: UILabel {

  //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  //common func to init our view
  private func setupView() {
    font = UIFont.systemFont(ofSize: 20, weight: .medium)
  }
}

class WidgetLabel: UILabel {

  //initWithFrame to init view from code
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  //initWithCode to init view from xib or storyboard
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  //common func to init our view
  private func setupView() {
    font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
}
