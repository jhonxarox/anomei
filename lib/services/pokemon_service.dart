import 'package:anemoi/models/pokemon.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonService {
  final String _pokemonQuery = """
  query {
    pokemons(first: 10) {
    id
    number
    name
    weight {
      minimum
      maximum
    }
    height {
      minimum
      maximum
    }
    classification
    types
    resistant
    attacks {
      fast {
        name
        type
        damage
      }
      special {
        name
        type
        damage
      }
    }
    weaknesses
    fleeRate
    maxCP
    evolutions {
      id
      name
    }
    evolutionRequirements {
      name
      amount
    }
    maxHP
    image
    }
  }
  """;

  Future<List<Pokemon>> fetchPokemons() async {
    final HttpLink httpLink = HttpLink('https://graphql-pokemon2.vercel.app');
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final QueryOptions options = QueryOptions(
      document: gql(_pokemonQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List pokemons = result.data?['pokemons'];

    print("Number of Pokemons fetched: ${pokemons.length}");
    print("Raw Pokemons JSON: $pokemons");

    for (int i = 0; i < pokemons.length; i++) {
      print("Parsing Pokemon JSON: ${pokemons[i]}");
      try {
        final pokemon = Pokemon.fromJson(pokemons[i]);
        print("Parsed Pokemon: ${pokemon.types}");
      } catch (e) {
        print("Error parsing Pokemon JSON: $e");
      }
    }

    return pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}
