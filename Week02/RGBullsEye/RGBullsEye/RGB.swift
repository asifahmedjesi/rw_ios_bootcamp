
import Foundation
import UIKit

struct RGB {
    var r = 127
    var g = 127
    var b = 127

    func difference(target: RGB) -> Double {
        let rDiff = Double(r - target.r)
        let gDiff = Double(g - target.g)
        let bDiff = Double(b - target.b)
        return sqrt((rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)/3.0) / 255.0
    }
}
