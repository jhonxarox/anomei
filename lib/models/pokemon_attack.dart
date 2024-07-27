class PokemonAttack {
  List<Attack>? fast;
  List<Attack>? special;

  PokemonAttack({
    this.fast,
    this.special,
  });

  factory PokemonAttack.fromJson(Map<String, dynamic> json) {
    return PokemonAttack(
      fast: (json['fast'] as List<dynamic>?)
          ?.map((attack) => Attack.fromJson(attack as Map<String, dynamic>))
          .toList(),
      special: (json['special'] as List<dynamic>?)
          ?.map((attack) => Attack.fromJson(attack as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'PokemonAttack{fast: $fast, special: $special}';
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
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      damage: json['damage'] as int?,
    );
  }

  @override
  String toString() {
    return 'Attack{name: $name, type: $type, damage: $damage}';
  }
}
