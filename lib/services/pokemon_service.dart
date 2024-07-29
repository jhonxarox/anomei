import 'package:anemoi/models/pokemon.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonService {
  Future<List<Pokemon>> fetchPokemons(int first) async {
    final String pokemonQuery = """
    query {
      pokemons(first: $first) {
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
        number
        types
        image
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

    final HttpLink httpLink = HttpLink('https://graphql-pokemon2.vercel.app');
    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final QueryOptions options = QueryOptions(
      document: gql(pokemonQuery),
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List pokemons = result.data?['pokemons'];

    return pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}
