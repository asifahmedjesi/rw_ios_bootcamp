
import UIKit

class CompactViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  
  let dataSource = CompactDataSource()
   let delegate = CompactCollectionViewDelegate(numberOfItemsPerRow: 3, interItemSpacing: 8)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureCollectionView()
  }

  func configureCollectionView() {
    self.collectionView.backgroundColor = .clear
    self.collectionView.delegate = delegate
    self.collectionView.dataSource = dataSource
    if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .vertical
    }
    self.collectionView.register(CompactViewCell.nib, forCellWithReuseIdentifier: CompactViewCell.identifier)
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)

      guard previousTraitCollection != nil else { return }
      collectionView?.collectionViewLayout.invalidateLayout()
  }
  
}


