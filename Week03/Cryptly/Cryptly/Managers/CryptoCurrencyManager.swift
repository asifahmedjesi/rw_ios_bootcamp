
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

  func getOwnedCryptoCurrencyNames() -> String {
    return String(self.list.reduce("") { $0 + $1.name + ", " }.dropLast(2))
  }
  //func getOwnedCryptoCurrencyNames() -> String {
  //  return self.list.map { $0.name }.joined(separator: ", ")
  //}

  func getRisingCryptoCurrencyNames() -> String {
    return String(self.list.filter { $0.trend == .rising } .reduce("") { $0 + $1.name + ", " }.dropLast(2))
  }
  //func getRisingCryptoCurrencyNames() -> String {
  //  return self.list.filter { $0.trend == .rising } .map { $0.name }.joined(separator: ", ")
  //}

  func getFallingCryptoCurrencyNames() -> String {
    return String(self.list.filter { $0.trend == .falling } .reduce("") { $0 + $1.name + ", " }.dropLast(2))
  }
  //func getFallingCryptoCurrencyNames() -> String {
  //  return self.list.filter { $0.trend == .falling } .map { $0.name }.joined(separator: ", ")
  //}

  func getMostFallingValue() -> Double {
    return list.filter({ $0.trend == .falling }).map({ $0.valueRise }).min() ?? 0.0
  }
  func getMostRisingValue() -> Double {
    return list.filter({ $0.trend == .rising }).map({ $0.valueRise }).max() ?? 0.0
  }

}
