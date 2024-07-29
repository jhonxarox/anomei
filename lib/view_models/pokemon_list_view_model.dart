import 'package:anemoi/models/pokemon.dart';
import 'package:anemoi/services/pokemon_service.dart';
import 'package:flutter/material.dart';

class PokemonListViewModel extends ChangeNotifier {
  final PokemonService _service = PokemonService();
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];
  bool _isLoading = false;
  int _first = 10;
  bool _hasMore = true;

  List<Pokemon> get pokemons =>
      _filteredPokemons.isNotEmpty ? _filteredPokemons : _pokemons;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchPokemons() async {
    _isLoading = true;
    notifyListeners();
    try {
      final newPokemons = await _service.fetchPokemons(_first);
      if (newPokemons.length < _first) {
        _hasMore = false;
      }
      _pokemons = newPokemons;
    } catch (e) {
      // Handle exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void loadMorePokemons() {
    if (_hasMore && !_isLoading) {
      _first += 10;
      fetchPokemons();
    }
  }

  void filterPokemonsByType(String type) {
    if (type.isEmpty) {
      _filteredPokemons = [];
    } else {
      _filteredPokemons = _pokemons
          .where((pokemon) => pokemon.types?.contains(type) ?? false)
          .toList();
    }
    notifyListeners();
  }
}
