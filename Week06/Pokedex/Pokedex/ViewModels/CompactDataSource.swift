import Foundation
import UIKit

class CompactDataSource: NSObject, UICollectionViewDataSource {
  
  let list = PokemonGenerator.shared.generatePokemons()
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return list.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompactViewCell.identifier, for: indexPath) as? CompactViewCell else {
      fatalError("Cell cannot be created")
    }
    let item = list[indexPath.row]
    cell.pokenmonImage.image = UIImage(named: "\(item.pokemonID)")
    cell.pokemonNameLabel.text = item.pokemonName
    cell.layer.cornerRadius = 8
    cell.clipsToBounds = true
    return cell
  }
}
