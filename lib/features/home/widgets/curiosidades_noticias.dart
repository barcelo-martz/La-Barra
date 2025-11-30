import 'package:flutter/material.dart';

class CuriosidadesBlock extends StatelessWidget {
  const CuriosidadesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final curiosidades = [
      'El Mojito era el cóctel favorito de Hemingway.',
      'El Margarita es uno de los tragos más pedidos en el mundo.',
      'El Daiquiri nació en Cuba a finales del siglo XIX.',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Curiosidades',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ...curiosidades.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Colors.redAccent),
                const SizedBox(width: 8),
                Expanded(child: Text(c)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}