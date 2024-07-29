import 'package:anemoi/models/pokemon.dart';
import 'package:anemoi/models/pokemon_attack.dart';
import 'package:anemoi/shared_widget/pokemon_evolution_widget.dart';
import 'package:anemoi/utils/color_utils.dart';
import 'package:flutter/material.dart';

class PokemonDetailView extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  _buildImageSection(),
                  const SizedBox(height: 16),
                  _buildDetailsSection(),
                  const SizedBox(height: 16),
                  _buildTypeSection(),
                  const SizedBox(height: 16),
                  _buildWeakenessSection(),
                  const SizedBox(height: 16),
                  _buildStatSection(),
                  const SizedBox(height: 16),
                  _buildAttackSection(pokemon),
                  const SizedBox(height: 16),
                  _buildEvolutionRequirementSection(pokemon),
                  const SizedBox(height: 16),
                  EvolutionsSection(evolutions: pokemon.evolutions ?? []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: <Widget>[
        Text(
          '#${pokemon.number}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Image.network(
          pokemon.image,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      color: const Color(0xFF539DDF),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Height', pokemon.getHeight()),
          _buildDetailRow('Weight', pokemon.getWeight()),
          _buildDetailRow('Flee Rate', pokemon.fleeRate.toString()),
          _buildDetailRow('Max CP', pokemon.maxCP.toString()),
          _buildDetailRow('Category', pokemon.classification ?? 'Unknown'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSection() {
    return Column(
      children: <Widget>[
        const Text(
          'Type',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: pokemon.types!.map((type) {
            return Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
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
    );
  }

  Widget _buildWeakenessSection() {
    return Column(
      children: <Widget>[
        const Text(
          'Weaknesses',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: pokemon.weaknesses!.map((weakness) {
            return Container(
              margin: const EdgeInsets.only(right: 4),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              decoration: BoxDecoration(
                color: getTypeColor(weakness),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                weakness,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStatSection() {
    return Column(
      children: <Widget>[
        const Text(
          'Stats',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildStatsBar('HP', pokemon.maxHP ?? 0, Colors.red),
        _buildStatsBar('Max CP', pokemon.maxCP ?? 0, Colors.blueAccent),
      ],
    );
  }

  Widget _buildStatsBar(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Container(
              width: (value / 4),
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Center(
              child: Text(
                '$value',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildAttackSection(Pokemon pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Attacks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        _buildAttackTable(pokemon.attacks?.fast ?? [], 'Fast Attacks'),
        _buildAttackTable(pokemon.attacks?.special ?? [], 'Special Attacks'),
      ],
    );
  }

  Widget _buildAttackTable(List<Attack> attacks, String title) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 59, 161).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            border: TableBorder.all(color: Colors.white),
            children: [
              const TableRow(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Damage',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              ...attacks.map(
                (attack) {
                  return TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        attack.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        attack.damage.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        attack.type ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEvolutionRequirementSection(Pokemon pokemon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 51, 125, 20).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evolution Requirement',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text('Name: ${pokemon.pokemonEvolutionRequirement?.name ?? 'N/A'}'),
          Text(
              'Amount: ${pokemon.pokemonEvolutionRequirement?.amount ?? 'N/A'}'),
        ],
      ),
    );
  }
}
