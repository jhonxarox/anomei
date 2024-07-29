import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  switch (type.toLowerCase()) {
    case 'bug':
      return const Color(0xFF92BC2C);
    case 'dark':
      return const Color(0xFF595761);
    case 'dragon':
      return const Color(0xFF0C69C8);
    case 'electric':
      return const Color(0xFFF2D94E);
    case 'fairy':
      return const Color(0xFFEE90E6);
    case 'fighting':
      return const Color(0xFFD3425F);
    case 'fire':
      return const Color(0xFFFBA54C);
    case 'flying':
      return const Color(0xFFA1BBEC);
    case 'ghost':
      return const Color(0xFF5F6DBC);
    case 'grass':
      return const Color(0xFF5FBD58);
    case 'ground':
      return const Color(0xFFD78555);
    case 'ice':
      return const Color(0xFF75D0C1);
    case 'normal':
      return const Color(0xFFA0A29F);
    case 'poison':
      return const Color(0xFFB763CF);
    case 'psychic':
      return const Color(0xFFFA8581);
    case 'rock':
      return const Color(0xFFC9BB8A);
    case 'steel':
      return const Color(0xFF5695A3);
    case 'water':
      return const Color(0xFF539DDF);
    default:
      return Colors.grey;
  }
}
