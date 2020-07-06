import Foundation

class PokemonGenerator {
  
  public static let shared = PokemonGenerator()
  
  private init () { }
  
  func generatePokemons() -> [Pokemon] {
    var pokemons: [Pokemon] = []
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
    do {
      let csv = try CSV(contentsOfURL: path ?? "")
      let rows = csv.rows
      for row in rows {
        let pokeID = Int(row["id"] ?? "") ?? 0
        let name = row["identifier"] ?? ""
        let weight = Int(row["weight"] ?? "") ?? 0
        let height = Int(row["height"] ?? "") ?? 0
        let baseExp = Int(row["base_experience"] ?? "") ?? 0
        let pokemon = Pokemon(pokemonID: pokeID, pokemonName: name.capitalized, baseExp: baseExp, height: height, weight: weight)
        pokemons.append(pokemon)
      }
      return pokemons
    } catch let error {
      print("\(error.localizedDescription)")
    }
    return pokemons
  }
}
