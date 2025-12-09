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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(trago.nombre),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              trago.imagen,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trago.nombre,
                style: textTheme.headlineSmall?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trago.categoria,
                  style: textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Text(
            trago.descripcion,
            style: textTheme.bodyMedium?.copyWith(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          const Divider(height: 32),

          const Row(
            children: [
              Icon(Icons.kitchen, color: colorScheme.secondary),
              const SizedBox(width: 8),
              Text('Ingredientes', style: textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ...trago.ingredientes.map((i) => Text('• $i', style: textTheme.bodyMedium)),
          const Divider(height: 32),

          const Row(
            children: [
              Icon(Icons.menu_book, color: colorScheme.secondary),
              const SizedBox(width: 8),
              Text('Preparación', style: textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(trago.preparacion, style: textTheme.bodyMedium),
          const Divider(height: 32),

          const Row(
            children: [
              Icon(Icons.build, color: colorScheme.secondary),
              const SizedBox(width: 8),
              Text('Herramientas', style: textTheme.titleMedium?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          ...trago.herramientas.map((h) => Text('• $h', style: textTheme.bodyMedium)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.secondary,
        child: Icon(
          esFavorito ? Icons.favorite : Icons.favorite_border,
          color: colorScheme.onSecondary,
        ),
        onPressed: () => favoritos.toggleFavorito(trago),
      ),
    );
  }
}