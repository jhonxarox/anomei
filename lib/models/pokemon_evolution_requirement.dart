class PokemonEvolutionRequirement {
  String? name;
  int? amount;

  PokemonEvolutionRequirement({
    this.name,
    this.amount,
  });

  factory PokemonEvolutionRequirement.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionRequirement(
      name: json['name'] ?? '',
      amount: json['amount'] as int?,
    );
  }
}
