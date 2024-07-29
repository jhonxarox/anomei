import 'package:anemoi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:anemoi/models/pokemon.dart';

class EvolutionsSection extends StatelessWidget {
  final List<Pokemon> evolutions;

  const EvolutionsSection({super.key, required this.evolutions});

  @override
  Widget build(BuildContext context) {
    return evolutions.isEmpty
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF3C3C3C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Evolutions',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: evolutions
                      .map((pokemon) => _buildEvolutionItem(pokemon))
                      .toList(),
                ),
              ],
            ),
          );
  }

  Widget _buildEvolutionItem(Pokemon pokemon) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(pokemon.image),
              radius: 35,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '#${pokemon.number}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pokemon.types!.map((type) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getTypeColor(type),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        evolutions.last != pokemon
            ? const Icon(
                Icons.arrow_downward,
                color: Colors.white,
              )
            : Container(),
        const SizedBox(height: 16),
      ],
    );
  }
}
