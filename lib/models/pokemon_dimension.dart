class PokemonDimension {
  String? min;
  String? max;

  PokemonDimension({
    this.min,
    this.max,
  });

  factory PokemonDimension.fromJson(Map<String, dynamic> json) {
    return PokemonDimension(
      min: json['minimum'],
      max: json['maximum'],
    );
  }
}
