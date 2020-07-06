
import Foundation
import UIKit

class CompactCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  
  let numberOfItemsPerRow: CGFloat
  let interItemSpacing: CGFloat
  
  init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
    self.numberOfItemsPerRow = numberOfItemsPerRow
    self.interItemSpacing = interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxWidth = UIScreen.main.bounds.width
    let totalSpacing = (interItemSpacing * numberOfItemsPerRow) + interItemSpacing
    let itemWidth = (maxWidth - totalSpacing)/numberOfItemsPerRow
    
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: interItemSpacing, left: interItemSpacing, bottom: interItemSpacing, right: interItemSpacing)
  }
}
