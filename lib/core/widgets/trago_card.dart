import 'package:flutter/material.dart';
import 'package:la_barra/providers/favorites_provider.dart';
import 'package:provider/provider.dart';
import '../../models/trago_categoria.dart';
import 'trago_detalle_screen.dart';

class TragoCard extends StatelessWidget {
  final TragoCategoria trago;

  const TragoCard({super.key, required this.trago});

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();
    final esFavorito = favoritos.esFavorito(trago);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TragoDetalleScreen(trago: trago)),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Image.asset(trago.imagen, width: 80, height: 80, fit: BoxFit.cover),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trago.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(trago.descripcion),
                  Text(trago.categoria, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                esFavorito ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
              ),
              onPressed: () => favoritos.toggleFavorito(trago),
            ),
          ],
        ),
      ),
    );
  }
}