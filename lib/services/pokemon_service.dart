import 'package:anemoi/models/pokemon.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonService {
  final String _pokemonQuery = """
  query {
    pokemons(first: 10) {
      id
      name
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

    final List pokemons = result.data!['pokemons'];
    return pokemons.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}
