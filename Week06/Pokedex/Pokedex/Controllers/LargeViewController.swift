
import UIKit

class LargeViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let dataSource = LargeDataSource()
  let delegate = LargeCollectionViewDelegate(numberOfItemsPerRow: 1, interItemSpacing: 20)
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  }

}
