
import UIKit

class LargeViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let dataSource = LargeDataSource()
  let delegate = LargeCollectionViewDelegate(numberOfItemsPerRow: 1, interItemSpacing: 20)
  
  var isPortrait: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    checkForPortrait()
    dataSource.isPortrait = isPortrait
    configureCollectionView()
  }

  func configureCollectionView() {
    self.collectionView.backgroundColor = .clear
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
    }
    self.collectionView.register(LargeViewCell.nib, forCellWithReuseIdentifier: LargeViewCell.identifier)
    self.collectionView.register(LargeViewLandscapeCell.nib, forCellWithReuseIdentifier: LargeViewLandscapeCell.identifier)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    guard previousTraitCollection != nil else { return }
    
    checkForPortrait()
    dataSource.isPortrait = isPortrait
    
    //collectionView?.collectionViewLayout.invalidateLayout()

    collectionView?.reloadData()
  }
  
  func checkForPortrait() {
    if traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact && traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.regular {
      isPortrait = true
    } else {
      isPortrait = false
    }
  }

}
