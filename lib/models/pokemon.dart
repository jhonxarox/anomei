import 'package:anemoi/models/pokemon_attack.dart';
import 'package:anemoi/models/pokemon_dimension.dart';
import 'package:anemoi/models/pokemon_evolution_requirement.dart';

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
  PokemonEvolutionRequirement? pokemonEvolutionRequirement;

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
    this.pokemonEvolutionRequirement,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? '',
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
      pokemonEvolutionRequirement: json['evolutionRequirements'] != null
          ? PokemonEvolutionRequirement.fromJson(json['evolutionRequirements'])
          : null,
    );
  }

  String getHeight() {
    if (height == null) {
      return 'Unknown';
    }
    return '${height?.min} - ${height?.max}';
  }

  String getWeight() {
    if (weight == null) {
      return 'Unknown';
    }
    return '${weight?.min} - ${weight?.max}';
  }
}
