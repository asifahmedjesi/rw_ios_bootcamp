
import Foundation
import UIKit

class CryptoCurrencyManager {
  static let shared = CryptoCurrencyManager()
  
  private var list: [CryptoCurrency] {
    get {
      guard let _list = DataGenerator.shared.generateData() else { return [] }
      return _list
    }
  }
  
  private init() {}

  func getOwnedCryptoCurrencyNames() -> [String] {
    return self.list.map { $0.name }
  }
  func getRisingCryptoCurrencyNames() -> [String] {
    return self.list.filter { $0.trend == .rising } .map { $0.name }
  }
  func getFallingCryptoCurrencyNames() -> [String] {
    return self.list.filter { $0.trend == .falling } .map { $0.name }
  }
  func getMostFallingValue() -> Double {
    return list.filter({ $0.trend == .falling }).map({ $0.valueRise }).min() ?? 0.0
  }
  func getMostRisingValue() -> Double {
    return list.filter({ $0.trend == .rising }).map({ $0.valueRise }).max() ?? 0.0
  }

}
