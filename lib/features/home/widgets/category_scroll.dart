import 'package:flutter/material.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';

class CategoryScroll extends StatelessWidget {
  const CategoryScroll({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de categorías con su imagen y nombre
    final categories = [
      {'name': 'Clásicos', 'image': 'assets/images/categoria1.jpeg'},
      {'name': 'Tropicales', 'image': 'assets/images/categoria2.jpeg'},
      {'name': 'De Autor', 'image': 'assets/images/categoria3.jpeg'},
      {'name': 'Sin Alcohol', 'image': 'assets/images/categoria4.jpeg'},
      {'name': 'De Temporada', 'image': 'assets/images/categoria5.jpeg'},
      {'name': 'Postres', 'image': 'assets/images/categoria6.jpeg'},
      {'name': 'Shots', 'image': 'assets/images/categoria1.jpeg'},
    ];

    return SizedBox(
      height: 160, // altura para una sola fila
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final categoria = categories[index];
          return _buildCategoryCard(
            context,
            categoria['name']!,
            categoria['image']!,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String name, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CategoriaScreen(categoria: name)),
        );
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 140,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}