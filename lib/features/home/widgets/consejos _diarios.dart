import 'package:flutter/material.dart';

class ConsejosBlock extends StatelessWidget {
  const ConsejosBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final consejos = [
      'Agita siempre con hielo para enfriar y diluir correctamente.',
      'Usa vasos adecuados para cada tipo de cóctel.',
      'Decora con frutas frescas para dar un toque profesional.',
      'Prueba nuevas combinaciones, ¡la creatividad es clave!',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Consejos Diarios',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        ...consejos.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: Colors.orange),
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