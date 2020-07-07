import UIKit

enum ListSection: Int, CaseIterable {
  case main
}

class CompositionViewController: UIViewController {
  
  fileprivate typealias DataSource = UICollectionViewDiffableDataSource<ListSection, Pokemon>
  fileprivate typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ListSection, Pokemon>
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  fileprivate var dataSource: DataSource!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  private func setupView() {
    
    collectionView.backgroundColor = .clear
    
    collectionView.register(LargeViewCell.nib, forCellWithReuseIdentifier: LargeViewCell.identifier)
    
    collectionView.collectionViewLayout = configureCollectionViewLayout()
    configureDataSource()
    configureSnapshot()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)

      guard previousTraitCollection != nil else { return }
      collectionView?.collectionViewLayout.invalidateLayout()
  }

}

// MARK: - Collection View -
extension CompositionViewController {
  
  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    
    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)

      let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(500))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      group.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)

      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

      return section
      
    }
    
    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
  }
  
}

// MARK: - Diffable Data Source
extension CompositionViewController {
  
  func configureDataSource() {
    
    dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
      
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeViewCell.identifier, for: indexPath) as? LargeViewCell else {
        fatalError("Cannot create new cell")
      }
      
      cell.pokemonImage.image = UIImage(named: item.pokemonID.description)
      cell.pokemonNameLabel.text = item.pokemonName
      cell.baseExpLabel.text = item.baseExp.description
      cell.heightLabel.text = item.height.description
      cell.weightLabel.text = item.weight.description
      cell.layer.cornerRadius = 8
      cell.clipsToBounds = true
      
      return cell
    }
    
  }
  func configureSnapshot() {
    
    var snapshot = DataSourceSnapshot()
    
    snapshot.appendSections([.main])
    snapshot.appendItems(PokemonGenerator.shared.generatePokemons())

    dataSource.apply(snapshot, animatingDifferences: true)
    
  }
}
