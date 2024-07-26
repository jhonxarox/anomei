class PokemonAttack {
  Attack? fast;
  Attack? special;

  PokemonAttack({
    this.fast,
    this.special,
  });

  factory PokemonAttack.fromJson(Map<String, dynamic> json) {
    return PokemonAttack(
      fast: json['fast'],
      special: json['special'],
    );
  }
}

class Attack {
  String? name;
  String? type;
  int? damage;

  Attack({
    this.name,
    this.type,
    this.damage,
  });

  factory Attack.fromJson(Map<String, dynamic> json) {
    return Attack(
      name: json['name'],
      type: json['type'],
      damage: json['damage'],
    );
  }
}
