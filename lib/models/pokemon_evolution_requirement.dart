class PokemonEvolutionRequirement {
  String? name;
  String? amount;

  PokemonEvolutionRequirement({
    this.name,
    this.amount,
  });

  factory PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionRequirement(
      name: json['name'],
      amount: json['amount'],
    );
  }
}
