import 'package:anemoi/models/pokemon_attack.dart';
import 'package:anemoi/models/pokemon_dimension.dart';

class Pokemon {
  final String id;
  final String name;
  final String number;
  final String image;
  PokemonDimension? weight;
  PokemonDimension? height;
  String? classification;
  List<String>? types;
  List<String>? resistant;
  PokemonAttack? attacks;
  List<String>? weaknesses;
  double? fleeRate;
  int? maxCP;
  List<Pokemon>? evolutions;
  int? maxHP;

  Pokemon({
    required this.id,
    required this.name,
    required this.number,
    required this.image,
    this.weight,
    this.height,
    this.classification,
    this.types,
    this.resistant,
    this.attacks,
    this.weaknesses,
    this.fleeRate,
    this.maxCP,
    this.evolutions,
    this.maxHP,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      number: json['number'],
      image: json['image'],
      weight: json['weight'],
      height: json['height'],
      classification: json['classification'],
      types: json['types'],
      resistant: json['resistant'],
      attacks: json['attacks'],
      weaknesses: json['weaknesses'],
      fleeRate: json['fleeRate'],
      maxCP: json['maxCP'],
      evolutions: json['evolutions'],
      maxHP: json['maxHP'],
    );
  }
}
