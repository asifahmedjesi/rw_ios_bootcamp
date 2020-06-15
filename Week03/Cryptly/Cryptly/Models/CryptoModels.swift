
import Foundation

enum Trend: Int, Codable {
  case rising
  case falling
}

struct CryptoCurrency: Codable {

  var name: String
  var symbol: String
  var currentValue: Double
  var previousValue: Double
  var valueRise: Double {
    get {
      return currentValue - previousValue
    }
  }
  var trend: Trend {
    get {
      return currentValue > previousValue ? .rising : .falling
    }
  }
}
