
struct Pokemon: Hashable {
  var pokemonID: Int = 0
  var pokemonName: String = ""
  var baseExp: Int = 0
  var height: Int = 0
  var weight: Int = 0
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(pokemonID)
  }
  
  static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
    return lhs.pokemonID == rhs.pokemonID && lhs.pokemonName == rhs.pokemonName
  }
}
