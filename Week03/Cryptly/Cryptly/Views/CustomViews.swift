
import Foundation
import UIKit


protocol Roundable: UIView {
  var cornderRadius: CGFloat { get set }
  func round()
}

extension Roundable where Self: UIView {
  
  func round() {
    self.layer.cornerRadius = self.cornderRadius
  }
}

@IBDesignable
class CryptoView: UIView, Roundable {
  
  @IBInspectable
  var cornderRadius: CGFloat = 0.0 {
    didSet {
      setupView()
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    setupView()
  }

  //common func to init our view
  private func setupView() {
    backgroundColor = .systemGray6
    layer.borderColor = UIColor.lightGray.cgColor
    layer.borderWidth = 1.0
    layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
    layer.shadowOffset = CGSize(width: 0, height: 2)
    layer.shadowRadius = 4
    layer.shadowOpacity = 0.8
    round()
  }
}
