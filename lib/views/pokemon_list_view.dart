import 'package:anemoi/models/pokemon.dart';
import 'package:anemoi/utils/color_utils.dart';
import 'package:anemoi/view_models/pokemon_list_view_model.dart';
import 'package:anemoi/views/pokemon_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonListView extends StatefulWidget {
  const PokemonListView({super.key});

  @override
  _PokemonListViewState createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<PokemonListView> {
  final ScrollController _scrollController = ScrollController();
  String _selectedType = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<PokemonListViewModel>(context, listen: false);
      viewModel.fetchPokemons();
    });

    _scrollController.addListener(() {
      final viewModel =
          Provider.of<PokemonListViewModel>(context, listen: false);
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !viewModel.isLoading &&
          viewModel.hasMore) {
        viewModel.loadMorePokemons();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          _buildFilterDropdown(),
        ],
      ),
      body: Consumer<PokemonListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading && viewModel.pokemons.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount:
                viewModel.pokemons.length + (viewModel.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == viewModel.pokemons.length) {
                return const Center(child: CircularProgressIndicator());
              }
              final Pokemon pokemon = viewModel.pokemons[index];
              return _pokemonCard(context, pokemon);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: _selectedType.isEmpty ? null : _selectedType,
        hint: const Text('Filter by Type'),
        items: _getDropdownItems(),
        onChanged: (value) {
          setState(() {
            _selectedType = value ?? '';
          });
          final viewModel =
              Provider.of<PokemonListViewModel>(context, listen: false);
          viewModel.filterPokemonsByType(_selectedType);
        },
      ),
    );
  }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    const types = [
      'Grass',
      'Poison',
      'Fire',
      'Water',
      'Bug',
      'Normal',
      'Electric',
      'Ground',
      'Fairy',
      'Fighting',
      'Psychic',
      'Rock',
      'Ghost',
      'Ice',
      'Dragon',
      'Dark',
      'Steel',
    ];

    return types.map((type) {
      return DropdownMenuItem<String>(
        value: type,
        child: Text(type),
      );
    }).toList();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  pokemon.image,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '#${pokemon.number}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: pokemon.types!.map((type) {
                  return Container(
                    margin: const EdgeInsets.only(right: 4),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                      color: getTypeColor(type),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
