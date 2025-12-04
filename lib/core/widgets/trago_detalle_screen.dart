import 'package:flutter/material.dart';
import 'package:la_barra/models/trago_categoria.dart';
import 'package:provider/provider.dart';
import 'package:la_barra/providers/favorites_provider.dart';


class TragoDetalleScreen extends StatelessWidget {
  final TragoCategoria trago;

  const TragoDetalleScreen({super.key, required this.trago});

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();
    final esFavorito = favoritos.esFavorito(trago);

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        title: Text(trago.nombre),
        backgroundColor: const Color(0xFFE53935),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Imagen al inicio
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              trago.Imagen,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Nombre y categoría
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trago.nombre,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trago.categoria,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Descripción
          Text(
            trago.descripcion,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 32),

          // Ingredientes
          const Row(
            children: [
              Icon(Icons.kitchen, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Ingredientes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ...trago.ingredientes.map((i) => Text('• $i')),
          const Divider(height: 32),

          // Preparación
          const Row(
            children: [
              Icon(Icons.menu_book, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Preparación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(trago.preparacion),
          const Divider(height: 32),

          // Herramientas
          const Row(
            children: [
              Icon(Icons.build, color: Colors.redAccent),
              SizedBox(width: 8),
              Text('Herramientas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ...trago.herramientas.map((h) => Text('• $h')),
        ],
      ),

      // Solo botón de favoritos
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          esFavorito ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
        onPressed: () => favoritos.toggleFavorito(trago),
      ),
    );
  }
}