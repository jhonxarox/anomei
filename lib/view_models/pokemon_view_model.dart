import 'package:anemoi/models/pokemon.dart';
import 'package:anemoi/services/pokemon_service.dart';
import 'package:flutter/material.dart';

class PokemonViewModel extends ChangeNotifier {
  final PokemonService _service = PokemonService();
  List<Pokemon> _pokemons = [];
  bool _isLoading = false;

  List<Pokemon> get pokemons => _pokemons;
  bool get isLoading => _isLoading;

  void fetchPokemons() async {
    _isLoading = true;
    notifyListeners();
    try {
      _pokemons = await _service.fetchPokemons();
    } catch (e) {
      // Handle exception
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
