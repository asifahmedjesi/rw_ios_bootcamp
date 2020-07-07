
import Foundation
import UIKit

class LargeCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
  
  let numberOfItemsPerRow: CGFloat
  let interItemSpacing: CGFloat
  
  init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat) {
    self.numberOfItemsPerRow = numberOfItemsPerRow
    self.interItemSpacing = interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    if UIApplication.shared.statusBarOrientation.isLandscape {
      let maxWidth = collectionView.bounds.width - 150
      let height = collectionView.bounds.height - 40
      let totalSpacing = (interItemSpacing * numberOfItemsPerRow) + interItemSpacing
      let itemWidth = (maxWidth - totalSpacing)/numberOfItemsPerRow
      
      return CGSize(width: itemWidth, height: height)
    }
    else {
      let maxWidth = collectionView.bounds.width - 50
      let height = collectionView.bounds.height - 200
      let totalSpacing = (interItemSpacing * numberOfItemsPerRow) + interItemSpacing
      let itemWidth = (maxWidth - totalSpacing)/numberOfItemsPerRow
      
      return CGSize(width: itemWidth, height: height)
    }
    
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
