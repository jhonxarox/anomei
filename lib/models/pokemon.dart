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
      id: json['id'] ?? '', // Ensure default values or handle nulls
      name: json['name'] ?? '',
      number: json['number'] ?? '',
      image: json['image'] ?? '',
      weight: json['weight'] != null
          ? PokemonDimension.fromJson(json['weight'])
          : null,
      height: json['height'] != null
          ? PokemonDimension.fromJson(json['height'])
          : null,
      classification: json['classification'],
      types: (json['types'] as List<dynamic>?)
          ?.map((type) => type as String)
          .toList(),
      resistant: (json['resistant'] as List<dynamic>?)
          ?.map((res) => res as String)
          .toList(),
      attacks: json['attacks'] != null
          ? PokemonAttack.fromJson(json['attacks'])
          : null,
      weaknesses: (json['weaknesses'] as List<dynamic>?)
          ?.map((weakness) => weakness as String)
          .toList(),
      fleeRate: (json['fleeRate'] as num?)?.toDouble(),
      maxCP: json['maxCP'] as int?,
      evolutions: (json['evolutions'] as List<dynamic>?)
          ?.map((evolution) =>
              Pokemon.fromJson(evolution as Map<String, dynamic>))
          .toList(),
      maxHP: json['maxHP'] as int?,
    );
  }
}
