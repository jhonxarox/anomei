import 'package:anemoi/models/pokemon.dart';
import 'package:anemoi/view_models/pokemon_view_model.dart';
import 'package:anemoi/views/pokemon_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokedex')),
      body: Consumer<PokemonViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: viewModel.pokemons.length,
            itemBuilder: (context, index) {
              final Pokemon pokemon = viewModel.pokemons[index];
              return _pokemonCard(context, pokemon);
            },
          );
        },
      ),
    );
  }

  Widget _pokemonCard(BuildContext context, Pokemon pokemon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetailView(
              pokemon: pokemon,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(pokemon.image),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        pokemon.name,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        pokemon.classification ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        pokemon.types?.join(',') ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  pokemon.maxCP != null
                      ? Row(
                          children: <Widget>[
                            const Icon(
                              Icons.water_drop,
                              color: Colors.white,
                            ),
                            Text(
                              'CP : ${pokemon.maxCP}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  pokemon.maxHP != null
                      ? Row(
                          children: <Widget>[
                            const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                            Text(
                              'HP : ${pokemon.maxHP}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
