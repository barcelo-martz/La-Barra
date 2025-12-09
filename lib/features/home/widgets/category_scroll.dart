import 'package:flutter/material.dart';
import 'package:la_barra/features/categories/categoria_screen.dart';

class CategoryScroll extends StatelessWidget {
  const CategoryScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Clásicos', 'image': 'assets/images/Mojito.jpg'},
      {'name': 'Tropicales', 'image': 'assets/images/dd45d054dfce696b68bc0b43a11d1bfe_M.jpg'},
      {'name': 'Modernos', 'image': 'assets/images/57-Chevy-Drink-Cocktail-with-Southern-Comfort.jpg'},
      {'name': 'Sin Alcohol', 'image': 'assets/images/Non-Alcoholic_Mulled_Wine.jpg'},
      {'name': 'De Temporada', 'image': 'assets/images/Autumn_Spice.jpg'},
      {'name': 'Postres o Dulces', 'image': 'assets/images/crema-papaya-servida-licor-cassis-cerrar_519721-867.jpg'},
      {'name': 'Shots', 'image': 'assets/images/verdita.jpeg'},
    ];

    return SizedBox(
      height: 160, 
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