import 'package:flutter/material.dart';

class RetosLogrosBlock extends StatelessWidget {
  const RetosLogrosBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final retos = [
      {'icon': Icons.local_bar, 'title': 'Crea tu primer trago'},
      {'icon': Icons.favorite, 'title': 'Agrega 5 favoritos'},
      {'icon': Icons.explore, 'title': 'Explora todas las categorías'},
      {'icon': Icons.star, 'title': 'Logra 10 creaciones'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Retos y Logros',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: retos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final reto = retos[index];
              return Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(reto['icon'] as IconData, color: Colors.white, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      reto['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}