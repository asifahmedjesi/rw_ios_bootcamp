import Foundation
import UIKit

class LargeDataSource: NSObject, UICollectionViewDataSource {
  
  let list = PokemonGenerator.shared.generatePokemons()
  
  var isPortrait: Bool = false
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return list.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if isPortrait {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeViewCell.identifier, for: indexPath) as? LargeViewCell else {
        fatalError("Cell cannot be created")
      }
      let item = list[indexPath.row]
      cell.pokemonImage.image = UIImage(named: item.pokemonID.description)
      cell.pokemonNameLabel.text = item.pokemonName
      cell.heightLabel.text = item.height.description
      cell.weightLabel.text = item.weight.description
      cell.baseExpLabel.text = item.baseExp.description
      cell.layer.cornerRadius = 8
      cell.clipsToBounds = true
      return cell
    }
    
    else {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeViewLandscapeCell.identifier, for: indexPath) as? LargeViewLandscapeCell else {
        fatalError("Cell cannot be created")
      }
      let item = list[indexPath.row]
      cell.pokemonImage.image = UIImage(named: item.pokemonID.description)
      cell.pokemonNameLabel.text = item.pokemonName
      cell.heightLabel.text = item.height.description
      cell.weightLabel.text = item.weight.description
      cell.baseExpLabel.text = item.baseExp.description
      cell.layer.cornerRadius = 8
      cell.clipsToBounds = true
      return cell
    }
    
  }
}
